<h1>Trabalho-FSC</h1> 
<p>O trabalho da cadeira de Fundamentos de Sistemas Computacionais 
tem o objetivo de fazer um jogo de cartas black jack no RISC-V, ou seja, assembly</p>
<h2>Como que funciona?</h2>
<p>Black jack é um jogo de cartas em que no nosso caso jogado contra um "dealer" (o computador). O objetivo do jogo é ter
uma mão de cartas que somem o valor mais próximo possível de 21, sem ultrapassar esse valor. Cada carta tem
um valor numérico: cartas numeradas (2 a 10) de acordo com o número na carta, cartas de figuras (Rei, Dama,
Valete) têm valor 10. Por fim, o Ás pode valer 1 ou 11, sempre favorecendo o jogador, sem ultrapassar 21.</p>
<ul>
    <li>O jogador e o dealer recebem inicialmente 2 cartas. </li>
    <li>As cartas são representadas por números de 1 a 13, onde:</li>
    <ul> <li>1 = Ás</li>
            <li>2 a 10 = Cartas numeradas</li>
            <li>11 = Valete</li>
            <li>12 = Dama</li>
            <li>13 = Rei</li>
    </ul>
</ul>

<h2>Como é a lógica?</h2>
<p>
Recebe duas cartas cada um, o dealer revela uma para o jogador,
o jogador pode pedir <strong>Hit</strong> para comprar mais uma e assim chegar o mais proximo o possivel de 21, 
caso estoure ou se completa 21 o jogo para automaticamente, mas caso não aconteça o jogador pode pedir
<strong>Stand</strong> para parar e deixar o dealer jogar na sua vez.
</p>
<p>
Após todos jogarem e não estorarem os limites o valor das cartas do jodador e do dealer são comparados
qual for maior ganha e se forem igual empata.
</p>
