**Proyecto 1** 

Herramientas:
  1. Nasm
  2. Python 3
  3. Pygame
  4. Pillow
     
Ejecutar los siguientes comandos (Utilizando Ubuntu):  

  sudo apt-get install nasm
  
  sudo apt-get install python3-pygame
  
  sudo apt-get install python3-pillow
  
  git clone https://github.com/joseaam2020/jarroyo_computer_architecture_1_2025.git
  
  cd jarroyo_computer_architecture_1_2025/Proyecto\ 1/
  
  nasm -f elf32 -g -o main.o main.s
  
  nasm -f elf32 -g -o write.o write.s
  
  nasm -f elf32 -g -o interpolacion.o interpolacion.spython3 selector.py 
  
  ld -m elf_i386 -o program main.o interpolacion.o write.o
  
  python3 selector.py 
  
    
