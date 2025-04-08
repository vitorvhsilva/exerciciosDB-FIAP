set serveroutput on;
set verify off;

-- Aula 10 - 07/04

/*
begin
    exception
        when nome_excecao then
            comando;
        when nome_excecao then
            comando;
end;
*/

//predefinida

drop table aluno cascade constraints;
create table aluno (
    id number, 
    nome varchar2(255)
);

insert into aluno values (1, 'Brendon');
insert into aluno values (2, 'Vitor');
insert into aluno values (3, 'João');
insert into aluno values (3, 'Vinicius');
commit;

declare 
    v_id aluno.id%type := &id;
    v_nome aluno.nome%type;
begin
    select nome into v_nome from aluno where v_id = id;
    dbms_output.put_line(v_id || ' - ' || v_nome);
    exception
        when NO_DATA_FOUND then
            dbms_output.put_line('Nenhum aluno encontrado');
        when TOO_MANY_ROWS then
            dbms_output.put_line('Há mais de um aluno com esse ID');
        when OTHERS then
            dbms_output.put_line('Não sei de nada, contrate a assistência');
end;
    
//personalizada

/*
declare
    nome_excecao exception;
begin
    if ... then
        raise nome_excecao;
    end if;
    exception
        when nome_excecao then
            comandos;
end;
*/

declare 
    v_conta number(2);
    turma_cheia exception;
begin
    select count(id) into v_conta from aluno;
    if v_conta = 4 then
        raise turma_cheia;
    else
        insert into aluno values (5, 'Rafaela');
    end if;
    exception
        when turma_cheia then
            dbms_output.put_line('Turma cheia!!');
end;

/*
Exercício:
Crias as tabelas: Cliente: id_clie, nome_clie
                  Movimentacao: id_mov, dt_mov, valor_mov
                  Tipo_Mov: id_tipo, nome_tipo
Criar um bloco PL para:
- alimentar as tabelas cliente e tipo_mov
- realizar as possiveis movimentações e atualizar o saldo após as movimentações
- exibir as movimentações de um cliente específico
- exibir as movimentações de todos os clientes
*/

drop table cliente cascade constraints;
drop table movimentacao cascade constraints;
drop table tipo_mov cascade constraints;
create table cliente (
    id_clie number,
    nome_clie varchar2(255),
    constraint cliente_pk primary key(id_clie)
);
create table tipo_mov(
    id_tipo number,
    descricao varchar(255),
    constraint tipo_mov_pk primary key(id_tipo)
);
create table movimentacao (
    id_mov number,
    dt_mov date,
    valor_mov number,
    id_clie number,
    id_tipo number,
    constraint movimentacao_pk primary key(id_mov),
    constraint cliente_fk foreign key(id_clie) references cliente(id_clie),
    constraint tipo_mov_fk foreign key(id_tipo) references tipo_mov(id_tipo)
);

declare
    v_acao movimentacao.valor_mov%type := &acao;
    v_valor_movimentacao movimentacao.valor_mov%type;
    v_id movimentacao.valor_mov%type;
    v_tipo movimentacao.valor_mov%type;
    v_random movimentacao.valor_mov%type;
    cursor c_exibe;
begin
    //populando a tabela
    insert into tipo_mov values (1, 'Tipo 1');
    insert into tipo_mov values (2, 'Tipo 2');
    insert into tipo_mov values (3, 'Tipo 3');
    
    insert into cliente values (1, 'Vitor');
    insert into cliente values (2, 'João');
    
    insert into movimentacao values (1, TO_DATE('2025-04-02', 'YYYY-MM-DD'), 1000.0, 1, 1);
    insert into movimentacao values (2, TO_DATE('2025-04-03', 'YYYY-MM-DD'), 1200.0, 1, 3);
    insert into movimentacao values (3, TO_DATE('2025-04-07', 'YYYY-MM-DD'), 1000.0, 2, 2);
    //realizar as possiveis movimentações e atualizar o saldo após as movimentações
    if acao = 1 then
        dbms_output.put_line('Qual seu id?');
        v_id := &id;
        dbms_output.put_line('Qual o valor da movimentação?');
        v_valor_movimentacao := &valor_movimentacao;
        dbms_output.put_line('Qual o tipo da movimentação?');
        v_tipo := &tipo;
        v_random := ROUND(DBMS_RANDOM.VALUE(10, 10000));
        insert into movimentacao values (v_random, TO_DATE('2025-04-07', 'YYYY-MM-DD'), 
            v_valor_movimentacao, v_id, v_tipo);
        dbms_output.put_line('Movimentação feita!');    
    //exibir as movimentações de um cliente específico
    elsif acao = 2 then
        dbms_output.put_line('Qual seu id?');
        v_id := &id;
        c_exibe is select * from movimentacao where id_clie = v_id;
    //exibir as movimentações de todos os clientes
    elsif acao = 3 then
    
    else 
    
end;


        