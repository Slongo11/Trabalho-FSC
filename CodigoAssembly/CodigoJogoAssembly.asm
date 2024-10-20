############################
# Desenvolvendo o código abaixo em assembly do RISC-V.
############################
# 
############################
.data 
cartasJogador: .word 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0     # Posicao zero vai ser a quantidade de cartas na mao e de resto as cartas ou seja 2
cartasDealer:  .word 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0     # Posicao zero vai ser a quantidade de cartas na mao e de resto as cartas ou seja 2
cartas: .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
totalValorCartasJogador: .word 0 # valor total das cartas na mao 
totalValorCartasDealer: .word 0  # valor total das cartas na mao
imprimeInfoJogador: .string
imprimeInfoDealer: .string
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
    li t1, 1                        # t1 <= 1     
    bne t0, t1 default              # case 1: comeca jogo
    jal start

    saidaCase:

    #Menu do resto do jogo
    li a7, 4                # a7 <= 4 (print string)
    la a0, menuNext         # a0 <= &meu_texto
    ecall 

    #Le a proxima opcao do switch case
    li a7, 5		# ler int
    ecall
    mv t0, a0 		# t0 <= de a0

    j loopMenu

#     /**
#      * comeca o jogo para o usuário toda a lógica
#      */
#     public static void start(){
#         Scanner scanner = new Scanner(System.in);
#         int[] cartasJogador = new int[11]; // cartas do jogador
#         int[] cartasDealer = new int[11]; // cartas do dealer (maquina)
#         int[] cartasJogo = new int[22]; // cartas do jogo inteiro
#         int qtdCartasJogador = 2; // quantidade de cartas do jogador
#         int qtdCartasDealer = 2; // quantidade de cartas do dealer (maquina)
#
#         // da duas cartas a cada jogador
#         for (int i = 0; i < 2; i++) {
#             cartasJogador[i] = geraRandom();
#             cartasDealer[i] = geraRandom();
#             cartasJogo[i+2]= cartasJogador[i];
#             cartasJogo[i]= cartasDealer[i];
#         }
    start:
    addi sp, sp, -16        # abre espaco na stack
    sw ra, 0(sp)            # guarda o valor de retorno
    sw s0, 4(sp)            # guarda o valor s0
    sw s1, 8(sp)            # guarda o valor s1
    sw s2, 12(sp)           # guarda o valor s2
    
    #Declaracao das principais variavies
    la s0, cartasJogador        # cartasJogador(s0) <= &cartasJogador
    la s1, cartasDealer         # cartasDealer(s1) <= &cartasDealer
    la s2, cartas               # cartasJogo(s2) <= &cartas
    ##########################################
    
    # Realiza a primeira distribuicao de cartas
    li t0, 0                #int i = 0 (t0)
    li t1, 2                #t1 <= 2
    #for (int i = 0; i < 2; i++)
    loopForStart:
    bge t0, t1, fimLoopForStart # Caso i(t0) >= 2(t1) acaba
    addi t2, t0, 1              # novo i+1(t2)
    addi t5,t2, 1               # novo i+2(t5)
    slli t6, t0, 2              # t6 <= i(t0) mutiplica por 4
    slli t2, t2, 2              # i+1(t2)mutiplica por 4
    slli t5, t5, 2              # i+2(t5) mutiplica por 4
    add t3, s0, t2              # t3 <= &cartasJogador(s0)[i+1]
    add t4, s1, t2              # t4 <= &cartasDealer(s1)[i+1]
    
    jal geraRandom              # pula para gerar numero aleatorio
    sw a0, 0(t3)                # guarda o valor sorteado &cartasJogador(s0)[i+1](t3)
    add t6, s2, t6              # endereco de destino da carta
    sw a0,0(t6)                 # guarda na posicao

    jal geraRandom              # pula para gerar numero aleatorio
    sw a0, 0(t4)                # guarda o valor sorteado &cartasDealer(s1)[i+1](t4)
    add t5, s2, t5              # endereco de destino da carta
    sw a0,0(t5)                 # guarda na posicao
    

    addi t0, t0, 1              #i(t0)++
    j loopForStart
    fimLoopForStart:
#         // cada carta de 1-13
#         String cartasUsuario = cartasJogador[0] + " + " + cartasJogador[1];
#         String cartasMaquina = cartasDealer[0] + " + " + cartasDealer[1];
#         // faz a soma inicial
#         int valorCartaUsuario = somaCartas(cartasJogador,qtdCartasJogador);
#         int valorCartaMaquina = somaCartas(cartasDealer,qtdCartasDealer);
    
    mv a0, s0                           # move &cartasJogador(s0) para o argumento
    jal somaCartas                      # pula para a soma
    la t0, totalValorCartasJogador      # t0 <= &totalValorCartasJogador
    sw a0, 0(t0)                        # guarda na memoria o valor da soma

    
    mv a0, s1                           # move &cartasDealer(s0) para o argumento
    jal somaCartas                      # pula para a soma
    la t0,totalValorCartasDealer        # t0 <= &totalValorCartasDealer
    sw a0, 0(t0)                        # guarda na memoria o valor da soma

        
    # la a0,cartas            # primeiro argumento para a chada
    # a1                      # segundo argumento para a chamada
    # jal geraRandomMax4

    lw s2, 12(sp)           # guarda o valor s2
    lw s1, 8(sp)            # guarda o valor s1
    lw s0, 4(sp)            # guarda o valor s0
    lw ra, 0(sp)            # pega o valor de retorno
    addi sp, sp, 16         # fecha espaco na stack
    jr ra                   # pula para o loop de menu
    

#
#         int opcao = 0;
#         while (opcao != 2){
#
#             System.out.printf("""
#                             ==============JogoInfo===============
#                             O jogador revela: %s = %d
#                             O dealer revela: %d
#                             ====================================
#                             """,cartasUsuario, valorCartaUsuario ,cartasDealer[0]);
#             // fechou 21 ou estrapolou o limite
#             if(valorCartaUsuario >= 21)
#                 break;
#             System.out.println("""
#                         ========Escolha=======
#                         O que deseja fazer?
#                         [1] Hit
#                         [2] Stand
#                         ======================
#                         """);
#             opcao = scanner.nextInt();
#             if (opcao == 1 ){
#                 cartasJogador[qtdCartasJogador] = geraRandom(cartasJogo,qtdCartasJogador+qtdCartasDealer);
#                 qtdCartasJogador++;
#                 cartasUsuario += " + " + cartasJogador[qtdCartasJogador-1];
#                 valorCartaUsuario =  somaCartas(cartasJogador,qtdCartasJogador);
#
#             }
#
#         }
#         // chance para a maquina tirar 21 e empatar
#         if(valorCartaUsuario <= 21){
#             boolean run = true;
#             while (run){
#                 if (valorCartaMaquina < 17){
#                     cartasDealer[qtdCartasDealer] = geraRandom(cartasJogo,qtdCartasJogador+qtdCartasDealer);
#                     qtdCartasDealer++;
#                     cartasMaquina += " + " + cartasDealer[qtdCartasDealer-1];
#                     valorCartaMaquina =  somaCartas(cartasDealer, qtdCartasDealer);
#
#                     System.out.printf("""
#                                 --------------------------
#                                 Dealer recebeu: %d
#                                 Revela: %s = %d
#                                 --------------------------
#                                 """, cartasDealer[qtdCartasDealer-1], cartasMaquina, valorCartaMaquina);
#                 }
#                 else{
#                     System.out.printf("""
#                                 --------------------------
#                                 O dealer não comprou
#                                 Revela: %s = %d
#                                 --------------------------
#                                 """, cartasMaquina, valorCartaMaquina);
#                 }
#                 if (valorCartaMaquina >= 17){
#                     run = false;
#                 }
#
#             }
#             if(valorCartaMaquina > 21){
#                 System.out.println("""
#                                     $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
#                                     O jogador ganhou o dealer estorou!
#                                     $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
#                                     """);
#             }
#             else{
#                 if (valorCartaMaquina > valorCartaUsuario){
#                     System.out.println("""
#                                     ##################################
#                                     O dealer ganhou
#                                     ##################################
#                                     """);
#                 }
#                 if (valorCartaMaquina < valorCartaUsuario){
#                     System.out.println("""
#                                     $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
#                                     O jogador ganhou
#                                     $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
#                                     """);
#                 }
#                 if(valorCartaMaquina == valorCartaUsuario){
#                     System.out.println("""
#                                     =================================
#                                     Deu empate
#                                     =================================
#                                     """);
#                 }
#             }
#         }
#         else{
#             System.out.printf("""
#                             Dealer tinha: %s = %d
#                             """, cartasMaquina, valorCartaMaquina);
#             System.out.println("""
#                                    ##################################
#                                    O dealer ganhou o jagador estourou
#                                    ##################################
#                                    """);
#         }
#     }


    

#     public static void end(){
#         System.out.println("Volte sempre");
#     }
default:
#opcaoInvalida default
    li a7, 4                # a7 <= 4 (print string)
    la a0, opcaoInvalida    # a0 <= &meu_texto
    ecall

    j saidaCase             # volta para o fim do case
    
fim:
    #Mensagem fim
    li a7, 4                # a7 <= 4 (print string)
    la a0, mensagemFim      # a0 <= &meu_texto
    ecall 
    #encerra
    li a7, 93               # a7 <= 93 (exit)
    xor a0, a0, a0          # a0 <= 0
    ecall                   # exits

#     public static int somaCartas(int[] cartas, int quantidade){
#         int soma = 0;
#         for (int i = 0; i < quantidade; i++) {
#             // validando caso for as caso receba ajudar 1 ou 11
#             if (cartas[i] == 1 && soma < 11){
#                 soma += 11;
#             }else if(cartas[i] == 11 ||  cartas[i] == 12 || cartas[i] == 13 ){
#                 soma += 10;
#             }
#             else{
#                 soma += cartas[i];
#             }
#         }
#         return soma;
#     }
###################################################################################
#recebe em a0 e retorna em a0
somaCartas:

    li t0, 0            # soma(t0) <= 0
    lw t1, 0(a0)        # t1 <= quantidade de cartas do endereco(a0) posicao 0

    li t2, 1            # int i = 1 logo que as cartas estão na posiçao 1 em diante
    
    #for (int i = 1; i <= quantidade; i++)
    loopForSomaCartas:
    bgt t2, t1, fimLoopForSomaCartas    # Caso i(t2) > 2(t1) acaba
    slli t3, t2, 2                      # t3 <= i(t2) mutiplica por 4
    add t3, a0, t3                      # t3 <= &cartas(a0)[i(t3)]
    lw t4, 0(t3)                        # t4 <= o valor cartas[i](t3)

    #// validando caso for as caso receba ajudar 1 ou 11
    ##if (cartas[i] == 1 && soma < 11){
    li t5, 1                            # t5 <= 1
    bne t4, t5, nextIf                  # cartas[i](t4) != 1 pula para a proxima validadcao
    li t6, 11                           # t6 <= 11
    bge t0, t6, nextIf                  # soma(t0) >= 11 pula para a proxima validadcao
    add t0, t0, t6                      # soma(t0) <= soma+11 
    addi t2, t2, 1                      # i(t2)++;
    j loopForSomaCartas                 # pula para o loop novamente
    ##else if(cartas[i] == 11 ||  cartas[i] == 12 || cartas[i] == 13 )
    nextIf:
    li t6, 11                           # t6 <= 11
    beq t6, t4 add10                    # 11 == cartas[i] pula para somar 10
    li t6, 12                           # t6 <= 12
    beq t6, t4 add10                    # 12 == cartas[i] pula para somar 10
    li t6, 13                           # t6 <= 13
    beq t6, t4 add10                    # 13 == cartas[i] pula para somar 10

    
    add t0, t0, t4                      # soma(t0) <= soma(t0) + cartas[i](t4)


    addi t2, t2, 1                      # i(t2)++;
    j loopForSomaCartas                 # pula para o loop novamente
    fimLoopForSomaCartas:

    mv a0, t0                           # Passa o valor de retorno
    jr ra                               # Pula de volta para quem chamou

    # adiciona 10 na soma caso foi igual a 11, 12 ou 13
    add10:
    addi t0,t0, 10                      # soma(t0) <= soma(t0) + 10
    addi t2, t2, 1                      # i(t2)++;
    j loopForSomaCartas                 # pula de volta
###################################################################################
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
