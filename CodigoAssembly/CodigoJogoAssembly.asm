############################
# Desenvolvendo o código abaixo em assembly do RISC-V.
############################
# 
############################
.data 
cartas: .word
startNomeJogo: .string "\n============================\nBem-vindo ao jogo Black Jack\n============================ \n"
menuInico: .string "\n ============================\n| -----------menu------------ |\n| [1] para iniciar o programa |\n| [2] para parar o programa   |\n|============================ | \n"
opcaoInvalida: .string "\nNão existe essa opção\n"
menuNext: .string "\n======================\nDeseja jogar novamente?\n[1] Sim\n[2] Não\n======================\n"
mensagemFim: .string "\nVolte sempre\n"

############################

############################
.text # Codigo
.globl main


main:
# import java.util.Random;
# import java.util.Scanner;
#
# public class Main {
#
#     public static void main(String[] args) {
#         Scanner scanner = new Scanner(System.in);
#         System.out.println("""
#                              ============================
#                              Bem-vindo ao jogo Black Jack
#                              ============================
#                             """);
#         System.out.println("""
#                          ============================
#                           Deseja iniciar o programa?
#                         | -----------menu------------ |
#                         | [1] para iniciar o programa |
#                         | [2] para parar o programa   |
#                         |============================ |
#                         """);
#
#         int opcao = scanner.nextInt();
#         while (opcao != 2) {
#             switch (opcao) {
#                 case 1:
#                     start();
#                     break;
#                 default:
#                     System.out.println("Não existe essa opção");
#                     break;
#             }
#             System.out.print("""
#                         ======================
#                         Deseja jogar novamente?
#                         [1] Sim
#                         [2] Não
#                         ======================
#                         """);
#             opcao = scanner.nextInt();
#         }
#         end();
#
#     }
jogo:
    li s2, 0
    #Bem vindo
    li a7, 4                # a7 <= 4 (print string)
    la a0, startNomeJogo   # a0 <= &meu_texto
    ecall 

    #Menu inicial
    li a7, 4                # a7 <= 4 (print string)
    la a0, menuInico   # a0 <= &meu_texto
    ecall 

    #Comparacoes para o loop
    li a7, 5		# ler int
    ecall
    mv t0, a0 		# t0 <= de a0

    loopMenu:
    li t1, 2        # t1 <= 2
    beq t0, t1 fim     # while(opcao != 2)
    switchCase:
    #case 1
    li t1, 1                    # t1 <= 1     
    beq t0, t1 start              # case 1: comeca jogo

    #opcaoInvalida default
    li a7, 4                # a7 <= 4 (print string)
    la a0, opcaoInvalida   # a0 <= &meu_texto
    ecall

    #Menu do resto do jogo
    li a7, 4                # a7 <= 4 (print string)
    la a0, menuNext   # a0 <= &meu_texto
    ecall 

    #Le a proxima opcao do switch case
    li a7, 5		# ler int
    ecall
    mv t0, a0 		# t0 <= de a0

    j loopMenu

    start:
    la a0,cartas
    addi a1,s2, 0
    jal geraRandomMax4
    addi s2,s2,1
    la s3, cartas
    mv s1, a0
    li t3, 0                            # int i = 0 (t3)
    #for(int i = 0; i < quantidade; i++)
    loopForTeste:
    bge t3, s2 fimLoopForTesete         # i >= quantidade(a1) acaba
    slli t4, t3, 2                       # t4 <= i(t3)*4
    add t5,s3, t4                       # t5 <= &cartas(s3)[i(t3)]
    lw t5, 0(t5)                        # t5 <= cartas(a0)[i(t3)] o valor
    
    li a7, 1
    mv a0, t5                           # TESTE PRITNA NUMEROS
    ecall

    elseTeste:
    addi t3, t3, 1                      # i(t3)++
    j loopForTeste

    fimLoopForTesete:
    
    j loopMenu
    

#     public static void end(){
#         System.out.println("Volte sempre");
#     }
fim:
    #Mensagem fim
    li a7, 4                # a7 <= 4 (print string)
    la a0, menuInico   # a0 <= &meu_texto
    ecall 
    #encerra
    li a7, 93          # a7 <= 93 (exit)
    xor a0, a0, a0     # a0 <= 0
    ecall              # exits

#     /**
#      * Gera cartas aleatórias sem que se repita mais que 4 cartas no jogo de 1-13
#      * @param cartas as cartas do universo do jogo ja utilizadas
#      * @param quantidade quantidade cartas no jogo geradas
#      * @return um numero aleatorio entre 1-13
#      */
#     public static int geraRandom(int[] cartas, int quantidade){
#         int valor= 1;
#         int contardor =0;
#         boolean run = true;
#         while (contardor >= 4 || run) {
#             valor = geraRandom();
#             contardor= 0;
#             for (int i = 0; i < quantidade; i++) {
#                 if (cartas[i] == valor) {
#                     contardor++;
#                 }
#             }
#             run =false;
#         }
#         cartas[quantidade]=valor;
#         return valor;
#     }
geraRandomMax4:
    addi sp, sp, -16                     # abrindo espaco no stack pointer
    sw ra, 0(sp)                         # salva o registrador para voltar na linha
    sw s0, 4(sp)                         # salva o antigo valor de s0

    li t0, 4                            # contardor(t0) <= 4 para comecar o loop
    #while(contardor >= 4)
    loopRandom:
    li t1, 4                            # t1 <= 4
    blt t0, t1 returnGeraRandomMax4     # Contador(t0) < 4(t1) ? sai : continua
    sw a0, 8(sp)                        # salva o valor do argumento a0
    sw a1, 12(sp)                       # salva o valor do argumento
    jal geraRandom                      # Sorteia valor
    mv s0, a0                           # Valor sorteador(s0) <= a0
    lw a0, 8(sp)                        # Volta o valor de a0
    lw a1, 12(sp)                       # Volta o valor de a1

    li, t0, 0                           #contardor(t0) <= 0
    
    li t3, 0                            # int i = 0 (t3)
    #for(int i = 0; i < quantidade; i++)
    loopForRandom:
    bge t3, a1 fimLoopForRandom         # i >= quantidade(a1) acaba
    slli t4, t3, 2                      # t4 <= i(t3)*4
    add t5,a0, t4                       # t5 <= &cartas(a0)[i(t3)]
    lw t5, 0(t5)                        # t5 <= cartas(a0)[i(t3)] o valor
    
    #If(cartas[i] == valor) 
    bne t5, s0, elseConta               # t5 ≠ Valor sorteador(s0) não conta
    addi t0,t0,1                        # contardor(t0)++

    elseConta:
    addi t3, t3, 1                      # i(t3)++
    j loopForRandom

    fimLoopForRandom:

    j loopRandom                        # Volta para o while(contardor >= 4)

    returnGeraRandomMax4:
    slli t0, a1, 2                      # t0 <= multiplica quantidade(a1) por 4
    add t3, a0, t0                      # busca o endereco cartas(a0)[quantide(t0)]
    sw s0, 0(t3)                        # armazena o valor sorteado(s0) no endereco cartas(a0)[quantide(a1)]
    mv a0, s0                           # Retorno do metodo logo que a0 <= valor(s0)

    lw s0, 4(sp)                        # Retorna o valor de s0
    lw ra, 0(sp)                        # Retorna o valor de volta da chamada
    addi sp, sp, 16                     # Fecha o espaço da stack
    
    jr ra                               # pula para a as proximas instrucoes


#     /**
#      * Gera um numero entre 1 e 13
#      * @return numero aleatorio 1-13
#      */
#     public static int geraRandom() {
#         Random random = new Random();
#         return random.nextInt(12)+1;
#     }
#Gera um numero entre 1 e 13
geraRandom:
    li a7, 42
    li a1, 13
    ecall
    addi a0, a0, 1
    jr ra

############################
