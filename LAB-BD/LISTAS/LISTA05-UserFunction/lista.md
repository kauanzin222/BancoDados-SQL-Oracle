Lista de exercícios - USER FUNCTION                                  Disciplina de LBD  

1- Escreva uma função FN_verHora que receba como parâmetro uma data no formato dd/mm/yyyy e 
    devolva-a no formato dd/mm/yyyy:HH24:mi:ss.

2- Escreva uma função que receba como parâmetro um código de Paciente (modelo Paciente-consulta) e 
devolva “IDOSO” se o paciente tiver mais de 65 anos. 
Caso contrário devolva “NÃO IDOSO”.

3-	Crie uma função chamada FN_ConsultaEstoque que retorna a qtde corrente em estoque de determinado produto.
a-	Passe para a função o código do produto
b-	Crie o campo QTDE_estoque na tabela de produto.
c-	Crie uma forma de executar a função criada.


4- Escreva uma função que receba como parâmetro um número de telefone não formatado( só números) e 
exiba este número no formato: (xx)xxxx-xxxx

5- Escreva uma função que receba como parâmetro o código do cliente e conte quantos pedidos ele tem.

Se ele tiver mais de 3 pedidos devolver mensagem:
        'Cliente preferencial'  concatenado com o código e nome do cliente.

Se tiver entre 1 e 3 devolver mensagem 'Cliente Normal' 
                              concatenado com o código e nome do cliente
Se não tiver pedidos 'Cliente Inativo' 
                              concatenado com o código e nome do cliente;

Testar se o cliente existe, caso contrário emitir mensagem de erro.
