-- Aula - 08/09/25

-- Pacotes - Package - Organizacao dos processos que a gente tem

set serveroutput on
set verify off

create or replace package teste1
as
    disciplina varchar2(20) := 'DB Application';
    unidade varchar2(30) := 'Fiap - Paulista - Manha';
end teste1;
/

declare 
    concatena varchar2(100);
begin
    concatena := teste1.disciplina || ', on FIAP';
    dbms_output.put_line(concatena);
end;
/

-- ex1 - media usando packages

create or replace package media
as
    num1 number := 10;
    num2 number := 10;
    div number := 2;
end media;
/

declare
    resultado number;
begin
    resultado := ( media.num1 + media.num2 ) / media.div;
    dbms_output.put_line('Resultado: ' || resultado);
end;
/

create or replace package media as
    function calcular_media (n1 in number, n2 in number, n3 in number)
    return number;
end media;

create or replace package body media as
    function calcular_media (n1 in number, n2 in number, n3 in number)
    return number
is 
    v_media number := 0;
begin
    v_media := (n1 + n2 + n3) / 3;
return v_media;
end calcular_media;
end media;

select round(media.calcular_media(10, 3, 10), 1) from dual;

drop table emp;
create table emp (empno number(3), sal number(8, 2));
insert into emp values (1, 1000);

create or replace package rh
as
    function descobrir_salario (p_id in emp.empno%type)
        return number;
    procedure reajuste(v_codigo_emp in emp.empno%type, v_porcentagem in number default 25);
end rh;
/

create or replace package body rh
as 
    function descobrir_salario (p_id in emp.empno%type)
        return number
        is
            v_salario emp.sal%type := 0;
        begin
            select sal into v_salario from emp where empno = p_id;
            return v_salario;
        end descobrir_salario;
    procedure reajuste(v_codigo_emp in emp.empno%type, v_porcentagem in number default 25)
    is 
    begin 
        update emp set sal = sal + (sal *(v_porcentagem / 100))
        where empno = v_codigo_emp;
        commit;
    end reajuste;
end rh; 
/

declare
    v_sal number(8,2);
begin
    v_sal := rh.descobrir_salario(1);
    dbms_output.put_line(v_sal);
end;