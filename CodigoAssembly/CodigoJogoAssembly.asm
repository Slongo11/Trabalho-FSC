############################
# Desenvolva o código abaixo em assembly do RISC-V.
############################
# 
############################
.data 
startNomeJogo: .string "\n============================\nBem-vindo ao jogo Black Jack\n============================ "
menuInico: .string "\n ============================\n| -----------menu------------ |\n| [1] para iniciar o programa |\n| [2] para parar o programa   |\n|============================ | "
opcaoInvalida: .string "\nNão existe essa opção"
menuNext: .string "\n======================\nDeseja jogar novamente?\n[1] Sim\n[2] Não\n======================"
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
    #Bem vindo
    li a7, 4                # a7 <= 4 (print string)
    la a0, startNomeJogo   # a0 <= &meu_texto
    ecall 

    #Menu inicial
    li a7, 4                # a7 <= 4 (print string)
    la a0, menuInico   # a0 <= &meu_texto
    ecall 

    #switch case:
    li a7, 8		# ler int
    la a0, buffer	# nome a ser armazenado
    li a1, 100		# condicao para no maximo 100 caracteres
    ecall
    mv s3, a0 		# s3 <=& de a0

    #opcaoInvalida
    li a7, 4                # a7 <= 4 (print string)
    la a0, opcaoInvalida   # a0 <= &meu_texto
    ecall 

    #Menu do resto do jogo
    li a7, 4                # a7 <= 4 (print string)
    la a0, menuNext   # a0 <= &meu_texto
    ecall 

    #encerra
    li a7, 93          # a7 <= 93 (exit)
    xor a0, a0, a0     # a0 <= 0
    ecall              # exits
############################