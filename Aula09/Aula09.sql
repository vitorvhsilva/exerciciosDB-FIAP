-- Aula 09 - 24/03

set serveroutput on;
set verify off;

create table funcionarios (
    cd_fun integer primary key,
    nm_fun varchar2(255),
    salario number,
    dt_adm date
);

insert into funcionarios values (1, 'Marcel', 10000, '17-APR-2000');
insert into funcionarios values (2, 'Claudia', 16000, '02-OCT-1998');
insert into funcionarios values (3, 'Joaquim', 5500, '10-JUL-2010');
insert into funcionarios values (4, 'Valéria', 7300, '08-JUN-2015');

declare
    cursor c_exibe is select nm_fun, salario from funcionarios;
    v_exibe c_exibe%rowtype;
begin
    open c_exibe;
    loop
        fetch c_exibe into v_exibe;
        exit when c_exibe%notfound;
        dbms_output.put_line('Nome: ' || v_exibe.nm_fun || ' - Salário: ' || v_exibe.salario);
    end loop;
    close c_exibe;
end;

declare
    cursor c_exibe is select nm_fun, salario from funcionarios;
    v_exibe c_exibe%rowtype;
begin
    for v_exibe in c_exibe loop
        dbms_output.put_line('Nome: ' || v_exibe.nm_fun || ' - Salário: ' || v_exibe.salario);
    end loop;
end;

alter table funcionarios add tempo number;

declare
    cursor c_exibe is select * from funcionarios;
begin
    for v_exibe in c_exibe loop
        update funcionarios set tempo = sysdate - v_exibe.dt_adm 
        where cd_fun = v_exibe.cd_fun;
    end loop;
end;

declare
    cursor c_exibe is select * from funcionarios;
begin
    for v_exibe in c_exibe loop
        update funcionarios set tempo = (sysdate - v_exibe.dt_adm) / 30 
        where cd_fun = v_exibe.cd_fun;
    end loop;
    for v_exibe in c_exibe loop
        if v_exibe.tempo > 150 then
            update funcionarios set salario = salario * 1.1 
            where cd_fun = v_exibe.cd_fun;
        else
            update funcionarios set salario = salario * 1.05 
            where cd_fun = v_exibe.cd_fun;
        end if;
    end loop;
end;

select * from funcionarios;