-- Aula 6 -  17/02

set serveroutput on -- habilita a saída de dados

set verify off -- desabilita a verificação da vm

declare
    v_n number(2) := 15;
begin
    if mod(v_n, 2) = 0 then
        dbms_output.put_line('O número ' || v_n || ' é par');
    else
        dbms_output.put_line('O número ' || v_n || ' é impar');
    end if;
end;    

declare
    genero varchar2(1) := upper('&i_genero');
begin
    if genero = 'M' then
        dbms_output.put_line('O gênero selecionado foi masculino');
    elsif genero = 'F' then
        dbms_output.put_line('O gênero selecionado foi feminino');
    else 
        dbms_output.put_line('O gênero selecionado foi outros');
    end if;
end;    

declare 
    v_carro number(10, 2) := &vi_carro;
    v_qtd_parcela v_carro%type := &vi_qtd_parcela;
    v_entrada_carro v_carro%type;
    v_restante_carro v_carro%type;
    v_parcela v_carro%type;
    v_total_carro v_carro%type;
begin
    v_entrada_carro := v_carro * 0.20;
    v_restante_carro := v_carro - v_entrada_carro;
    if v_qtd_parcela = 6 then
        v_parcela := (v_restante_carro * 1.1) / 6;
        v_total_carro := (v_restante_carro * 1.1) + v_entrada_carro;
        dbms_output.put_line('Valor total do carro: ' || v_total_carro || ', valor de cada parcela: ' || v_parcela);
    elsif v_qtd_parcela = 12 then        
        v_parcela := (v_restante_carro * 1.15) / 12;
        v_total_carro := (v_restante_carro * 1.15) + v_entrada_carro;
        dbms_output.put_line('Valor total do carro: ' || v_total_carro || ', valor de cada parcela: ' || v_parcela);
    elsif v_qtd_parcela = 18 then
        v_parcela := (v_restante_carro * 1.2) / 18;
        v_total_carro := (v_restante_carro * 1.12) + v_entrada_carro;
        dbms_output.put_line('Valor total do carro: ' || v_total_carro || ', valor de cada parcela: ' || v_parcela);
    else   
        dbms_output.put_line('Opção de parcela inválida');
    end if;
end;

declare 
    v_nota number(10, 2) := &vi_nota;
begin
    if not (v_nota > 10 or v_nota < 0) then
        if v_nota >= 9 then
            dbms_output.put_line('Aprovado com distinção');
        elsif v_nota >= 7 then
            dbms_output.put_line('Aprovado');
        elsif v_nota >= 5 then
            dbms_output.put_line('Recuperação');
        else
            dbms_output.put_line('Reprovado');
        end if;
    else
        dbms_output.put_line('Nota inválida');
    end if;
end;