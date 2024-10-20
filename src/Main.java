import java.util.Random;
import java.util.Scanner;

public class Main {

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.println("""
                             ============================
                             Bem-vindo ao jogo Black Jack
                             ============================
                            """);
        System.out.println("""
                         ============================
                          Deseja iniciar o programa?
                        | -----------menu------------ |
                        | [1] para iniciar o programa |
                        | [2] para parar o programa   |
                        |============================ |
                        """);

        int opcao = scanner.nextInt();
        while (opcao != 2) {
            switch (opcao) {
                case 1:
                    start();
                    break;
                default:
                    System.out.println("Não existe essa opção");
                    break;
            }
            System.out.print("""
                        ======================
                        Deseja jogar novamente?
                        [1] Sim
                        [2] Não
                        ======================
                        """);
            opcao = scanner.nextInt();
        }
        end();

    }

    /**
     * comeca o jogo para o usuário toda a lógica
     */
    public static void start(){
        Scanner scanner = new Scanner(System.in);
        int[] cartasJogador = new int[11]; // cartas do jogador
        int[] cartasDealer = new int[11]; // cartas do dealer (maquina)
        int[] cartasJogo = new int[22]; // cartas do jogo inteiro
        int qtdCartasJogador = 2; // quantidade de cartas do jogador
        int qtdCartasDealer = 2; // quantidade de cartas do dealer (maquina)

        // da duas cartas a cada jogador
        for (int i = 0; i < 2; i++) {
            cartasJogador[i] = geraRandom();
            cartasDealer[i] = geraRandom();
            cartasJogo[i+2]= cartasJogador[i];
            cartasJogo[i]= cartasDealer[i];
        }
        // cada carta de 1-13
        String cartasUsuario = cartasJogador[0] + " + " + cartasJogador[1];
        String cartasMaquina = cartasDealer[0] + " + " + cartasDealer[1];
        // faz a soma inicial
        int valorCartaUsuario = somaCartas(cartasJogador,qtdCartasJogador);
        int valorCartaMaquina = somaCartas(cartasDealer,qtdCartasDealer);

        int opcao = 0;
        while (opcao != 2){

            System.out.printf("""
                            ==============JogoInfo===============
                            O jogador revela: %s = %d
                            O dealer revela: %d
                            =====================================
                            """,cartasUsuario, valorCartaUsuario ,cartasDealer[0]);
            // fechou 21 ou estrapolou o limite
            if(valorCartaUsuario >= 21)
                break;
            System.out.println("""
                        ========Escolha=======
                        O que deseja fazer?
                        [1] Hit
                        [2] Stand
                        ======================
                        """);
            opcao = scanner.nextInt();
            if (opcao == 1 ){
                cartasJogador[qtdCartasJogador] = geraRandom(cartasJogo,qtdCartasJogador+qtdCartasDealer);
                qtdCartasJogador++;
                cartasUsuario += " + " + cartasJogador[qtdCartasJogador-1];
                valorCartaUsuario =  somaCartas(cartasJogador,qtdCartasJogador);

            }

        }
        // chance para a maquina tirar 21 e empatar
        if(valorCartaUsuario <= 21){
            boolean run = true;
            while (run){
                if (valorCartaMaquina < 17){
                    cartasDealer[qtdCartasDealer] = geraRandom(cartasJogo,qtdCartasJogador+qtdCartasDealer);
                    qtdCartasDealer++;
                    cartasMaquina += " + " + cartasDealer[qtdCartasDealer-1];
                    valorCartaMaquina =  somaCartas(cartasDealer, qtdCartasDealer);

                    System.out.printf("""
                                --------------------------
                                Dealer recebeu: %d
                                Revela: %s = %d
                                --------------------------
                                """, cartasDealer[qtdCartasDealer-1], cartasMaquina, valorCartaMaquina);
                }
                else{
                    System.out.printf("""
                                --------------------------
                                O dealer não comprou
                                Revela: %s = %d
                                --------------------------
                                """, cartasMaquina, valorCartaMaquina);
                }
                if (valorCartaMaquina >= 17){
                    run = false;
                }

            }
            if(valorCartaMaquina > 21){
                System.out.println("""
                                    $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
                                    O jogador ganhou o dealer estorou!
                                    $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
                                    """);
            }
            else{
                if (valorCartaMaquina > valorCartaUsuario){
                    System.out.println("""
                                    ##################################
                                    O dealer ganhou
                                    ##################################
                                    """);
                }
                if (valorCartaMaquina < valorCartaUsuario){
                    System.out.println("""
                                    $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
                                    O jogador ganhou
                                    $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
                                    """);
                }
                if(valorCartaMaquina == valorCartaUsuario){
                    System.out.println("""
                                    =================================
                                    Deu empate
                                    =================================
                                    """);
                }
            }
        }
        else{
            System.out.printf("""
                            Dealer tinha: %s = %d
                            """, cartasMaquina, valorCartaMaquina);
            System.out.println("""
                                   ##################################
                                   O dealer ganhou o jagador estourou
                                   ##################################
                                   """);
        }
    }

    public static void end(){
        System.out.println("Volte sempre");
    }

    /**
     * Soma o valor das cartas com a regra do jogo.
     * @param cartas a serem contadas
     * @param quantidade que está em sua mão
     * @return a soma dessas cartas
     */
    public static int somaCartas(int[] cartas, int quantidade){
        int soma = 0;
        for (int i = 0; i < quantidade; i++) {
            // validando caso for as caso receba ajudar 1 ou 11
            if (cartas[i] == 1 && soma < 11){
                soma += 11;
            }else if(cartas[i] == 11 ||  cartas[i] == 12 || cartas[i] == 13 ){
                soma += 10;
            }
            else{
                soma += cartas[i];
            }
        }
        return soma;
    }

    /**
     * Gera cartas aleatórias sem que se repita mais que 4 cartas no jogo de 1-13
     * @param cartas as cartas do universo do jogo ja utilizadas
     * @param quantidade quantidade cartas no jogo geradas
     * @return um numero aleatorio entre 1-13
     */
    public static int geraRandom(int[] cartas, int quantidade){
        int valor= 1;
        int contardor =0;
        boolean run = true;
        while (contardor >= 4 || run) {
            valor = geraRandom();
            contardor= 0;
            for (int i = 0; i < quantidade; i++) {
                if (cartas[i] == valor) {
                    contardor++;
                }
            }
            run =false;
        }
        cartas[quantidade]=valor;
        return valor;
    }
    /**
     * Gera um numero entre 1 e 13
     * @return numero aleatorio 1-13
     */
    public static int geraRandom() {
        Random random = new Random();
        return random.nextInt(12)+1;
    }
}