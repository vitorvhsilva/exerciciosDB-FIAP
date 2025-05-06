set serveroutput on
set verify off

--funções

/*
create or replace function nome_funcao (p1 in, p11 out, p111 in_out, p2...)
    return tipo_dados
    is
        variaveis_locais
    begin
        programacao
    return nome_funcao;
end;
*/

--in (padrao): passa um valor pra dentro da função e não pode ser atualizado (read-only)
--out: saida de dados por um processamento
--in_out: passa um valor pra dentro que pode ser alterado e retorna 

--dual -> tabela temporária

--select nome_funcao(val1, val2) from dual;

drop table funcionarios_tb1;

create table funcionarios_tb1(
    nome_func varchar2(255),
    id_func number(2) 
); 

insert into funcionarios_tb1 values ('Marcel', 10);
insert into funcionarios_tb1 values ('Andrea', 20);
insert into funcionarios_tb1 values ('Samuel', 90);
commit;

create or replace function primeiro_nome_func    
return varchar2
    is
        nome_funcionario varchar2(255);
    begin
        select nome_func into nome_funcionario from funcionarios_tb1
        where id_func = 10;
    return nome_funcionario;
end;

select primeiro_nome_func from dual;


create or replace function soma(p1 in number, p2 in number)
return number
is
    resultado_soma number;
begin 
    resultado_soma := p1 + p2;
    return resultado_soma;
end;

select soma(10, 15) from dual;

declare
    n1 number := &valor1;
    n2 n1%type := &valor2;
    re n1%type;
begin
    re := soma(n1, n2);
    dbms_output.put_line(re);
end;

create or replace function maior_num(p1 in number, p2 in number)
return number
is
    resultado number;
begin 
    if (p1 >= p2) then
        resultado := p1;
    else
        resultado := p2;
    end if;
    return resultado;
end;


select maior_num(10, 15) from dual;