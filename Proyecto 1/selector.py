from PIL import Image
import pygame
import sys
import numpy as np
import os
import subprocess

# Initialize pygame
pygame.init()

# Load an image
IMAGE_PATH = "Sargent3.png"  # Change this to your image path
image = pygame.image.load(IMAGE_PATH)

#Pillow is used to get pixel values
pil_img = Image.open(IMAGE_PATH).convert('L')

# Set up display
WIDTH, HEIGHT = image.get_size()
screen = pygame.display.set_mode((WIDTH*2, HEIGHT))
pygame.display.set_caption("Proyecto 1 Arquitectura Computadores")

# Grid settings
ROWS, COLS = 4, 4
CELL_WIDTH = WIDTH // COLS
CELL_HEIGHT = HEIGHT // ROWS

# Selected cell
selected_cell = None

# Main loop
running = True
np_array = np.array([])
np_array2 = np.array([])
while running:
    screen.blit(image, (0, 0))
    
    # Draw grid
    for row in range(ROWS + 1):
        pygame.draw.line(screen, (255, 255, 255), (0, row * CELL_HEIGHT), (WIDTH, row * CELL_HEIGHT), 2)
    for col in range(COLS + 1):
        pygame.draw.line(screen, (255, 255, 255), (col * CELL_WIDTH, 0), (col * CELL_WIDTH, HEIGHT), 2)
    
    # Highlight selected cell
    if selected_cell:
        x, y = selected_cell
        pygame.draw.rect(screen, (255, 0, 0), (x * CELL_WIDTH, y * CELL_HEIGHT, CELL_WIDTH, CELL_HEIGHT), 3)

    if (np_array.size > 0):
        np_array = np_array.astype(np.uint8) 
        cuadrant_img = Image.fromarray(np_array)
        cuadrant_img.save("cuadrant_img.png")
        cuadrant_img = pygame.image.load("cuadrant_img.png")
        screen.blit(cuadrant_img,(WIDTH,0))
    
    if (np_array2.size > 0):
        np_array2 = np_array2.astype(np.uint8) 
        interpolacion_img = Image.fromarray(np_array2)
        interpolacion_img.save("interpolacion_img.png")
        interpolacion_img = pygame.image.load("interpolacion_img.png")
        screen.blit(interpolacion_img,(WIDTH+cuadrant_img.get_width(),0))

    #Update
    pygame.display.flip()
    
    #Events
    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            running = False
        elif event.type == pygame.MOUSEBUTTONDOWN: #Mouse select
            mx, my = pygame.mouse.get_pos()
            selected_cell = (mx // CELL_WIDTH, my // CELL_HEIGHT)

            #Get pixels
            pixels = []
            for y in range(selected_cell[1]*CELL_HEIGHT,(selected_cell[1]+1)*CELL_HEIGHT):
                row = []
                for x in range(selected_cell[0]*CELL_WIDTH,(selected_cell[0]+1)*CELL_WIDTH):
                    pixel_value = pil_img.getpixel((x, y))
                    row.append(pixel_value)
                pixels.append(row)
            np_array = np.array(pixels)

            #Write pixel values to .img
            with open('pixel.img','w') as file:
                for y in range(0,CELL_HEIGHT,1):
                    for x in range(0,CELL_WIDTH,1):
                        if  (x < CELL_WIDTH-1 and y < CELL_HEIGHT-1): 
                            pixel1 = pixels[x][y]
                            pixel2 = pixels[x][y+1]
                            pixel3 = pixels[x+1][y]
                            pixel4 = pixels[x+1][y+1]

                            file.write(f"{pixel1}\n")
                            file.write(f"{pixel2}\n")
                            file.write(f"{pixel3}\n")
                            file.write(f"{pixel4}\n")

            #Delete previos interpolation values
            if os.path.exists("interpolacion.img"):
                os.remove("interpolacion.img")

            #Call assembly program
            cwd = os.getcwd()
            result = subprocess.run(cwd + "/program")
            print(result.stdout)

            #Read interpolation results
            result = np.zeros((CELL_WIDTH+2*(CELL_WIDTH-1),CELL_HEIGHT+2*(CELL_HEIGHT-1)))
            if os.path.exists("interpolacion.img"):
                 #Write pixel values to .img
                with open('pixel.img','r') as file1, open('interpolacion.img','r') as file2:
                    print(result.shape)
                    print(result.size)
                    for m in range(0,result.shape[1]-3,3):
                        for n in range (0,result.shape[0]-3,3):
                            for real_y in range(m,m+4):
                                relative_y = real_y % 4
                                for real_x in range(n,n+4):
                                    relative_x = real_x % 4
                                    match relative_y:
                                        case 0 | 3: 
                                            match relative_x:
                                                case 0 | 3:
                                                    result[real_x][real_y] = int(file1.readline().split()[0])
                                                case 1 | 2:
                                                    result[real_x][real_y] = int(file2.readline().split()[0])
                                        case 1 | 2:
                                            result[real_x][real_y] = int(file2.readline().split()[0])
                    #np.set_printoptions(threshold=np.inf)
                    #print(result)
                    np_array2 = result
                        



                                        

                    

            

pygame.quit()
sys.exit()