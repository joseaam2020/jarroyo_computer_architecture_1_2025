import pygame
import sys

# Initialize pygame
pygame.init()

# Load an image
IMAGE_PATH = "Sargent2.png"  # Change this to your image path
image = pygame.image.load(IMAGE_PATH)

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

pygame.quit()
sys.exit()