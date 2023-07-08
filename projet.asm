.data
msg1:.asciiz"entrer le nombre de lignes:"
msg2:.asciiz"\t "
msg3:.asciiz"\n"
X:.word 0



.text
.globl main 
main:
li $v0,4
la $a0,msg1   #affichage du msg1
syscall
li $v0,5
syscall       #saisir une valeur a partir du clavier
la $t0,X
sw $v0,0($t0)  #stocker la valeur saisie dans le segment data



lw $t1,0($t0)       #$t1=Nombre de lignes
	li $s2,2    #$s2=2
	li $t3,2   #initialisation du registre $t3 qui prend les valeurs a taister
	div $t3,$s2
	mflo $s5    # $s5=i/2 (nombre d'arret pour le test) 
	li $t4,0     #$t4=0(prend les nombres qu'on va voir est ce qui'ils sont des diviseurs du nombre qui dans le registre $t3)
	li $t7,1   #n=1
	li $t6,0
	li $s3,0     #compter le nombre de lignes $s3=0
	mult $t1,$s2
	mflo $s1   # nombre des espaces au debut de chaque lignes $s1=2*nombre de lignes
	j noop     #sauter vers label noop
	
for2:  
	
	bge $t4,$s5,affiche  
	nop
	addiu $t4,$t4,1   #incrementation $t4
	div $t3,$t4    # le test pour avoir les diviseurs du nombres premiers 
	mfhi $t5       #le reste de la division $t3 % $t4
	bnez $t5,for2  
	nop 
        addiu $t6,$t6,1  #$t6 pour compter le nombre des diviseurs
        
for1:

	beqz $t7,newligne  
	nop
	blt $s3,$t1,for2
        nop 
    	li $v0,10
	syscall	


	

affiche:
	
	
 	bne $t6,1,incre
	nop
	li $v0,4
	la $a0,msg2   #affichage du msg2
	syscall
	li $v0,1
	move $a0,$t3  #affichage du nombre premier
	syscall
	li $v0,4
	la $a0,msg2   #affichage du msg2
	syscall
	addiu $t7,$t7,-1  #décrementation de $t7


incre:
	addiu $t3,$t3,1
	div $t3,$s2       
	mflo $s5		#$t3 / $s2
	mfhi $s7 		#$t3 % $s2
	beqz $s7,incre    #si le nombre est pair on increment (pair->pas un nombre premier)
	nop
	li $t4,0   #renitialiser $t4 a zero
	li $t6,0   #renitialiser $t6 a zero
	j for2
	nop

newligne:
	li $v0,4
        la $a0,msg3   #affichage du msg3
        syscall
	addiu $s3,$s3,1
	addiu $t7,$s3,1

li $s4,0   
	blt $s3,$t1,noop  
        nop 
    	li $v0,10
	syscall	  #quitter le programme
noop:
li $v0,4
la $a0,msg2        #affichage du msg2
syscall
addiu $s4,$s4,1    #incrementation de $s4 qui compter le nombre des espaces
ble $s4,$s1,noop   #codition d'arret 
nop
addiu $s1,$s1,-1   #decrementation de nombres des espaces pour avoir la forme du triangle
  
j for2    #sauter vers label for2

	


