from PIL import Image
import pygame
import sys

# Initialize pygame
pygame.init()

# Load an image
IMAGE_PATH = "Sargent2.png"  # Change this to your image path
image = pygame.image.load(IMAGE_PATH)

#Pillow is used to get pixel values
pil_img = Image.open(IMAGE_PATH).convert('L')

# Set up display
WIDTH, HEIGHT = image.get_size()
screen = pygame.display.set_mode((WIDTH, HEIGHT))
pygame.display.set_caption("Proyecto 1 Arquitectura Computadores")

# Grid settings
ROWS, COLS = 4, 4
CELL_WIDTH = WIDTH // COLS
CELL_HEIGHT = HEIGHT // ROWS

# Selected cell
selected_cell = None

# Main loop
running = True
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

            with open('pixel.img','w') as file:
                for y in range(0,CELL_HEIGHT,2):
                    for x in range(0,CELL_WIDTH,2):
                        if  (x < CELL_WIDTH-1 and y < CELL_HEIGHT-1): 
                            pixel1 = pixels[x][y]
                            pixel2 = pixels[x][y+1]
                            pixel3 = pixels[x+1][y]
                            pixel4 = pixels[x+1][y+1]

                            file.write(f"{pixel1}\n")
                            file.write(f"{pixel2}\n")
                            file.write(f"{pixel3}\n")
                            file.write(f"{pixel4}\n")

            

pygame.quit()
sys.exit()