-- Aula 8 -  10/03

set serveroutput on -- habilita a saída de dados

set verify off -- desabilita a verificação da vm   

declare
    v_nome_materia varchar2(255);
    v_media number;
    v_resultado v_nome_materia%type;
begin
    v_nome_materia := 'BD';
    select media into v_media from notas where nome_materia = v_nome_materia;
    if v_media >= 7.0 then 
        v_resultado := 'A';
    elsif (v_media >= 5.0 or v_media <= 6.9) then
        v_resultado := 'Ex';
    else
        v_resultado := 'Rec';
    end if;
    update notas set situacao = v_resultado where nome_materia = v_nome_materia;
    
    v_nome_materia := 'IA';
    select media into v_media from notas where nome_materia = v_nome_materia;
    if v_media >= 7.0 then 
        v_resultado := 'A';
    elsif (v_media >= 5.0 or v_media <= 6.9) then
        v_resultado := 'Ex';
    else
        v_resultado := 'Rec';
    end if;
    update notas set situacao = v_resultado where nome_materia = v_nome_materia;
    
    v_nome_materia := 'Front';
    select media into v_media from notas where nome_materia = v_nome_materia;
    if v_media >= 7.0 then 
        v_resultado := 'A';
    elsif (v_media >= 5.0 or v_media <= 6.9) then
        v_resultado := 'Ex';
    else
        v_resultado := 'Rec';
    end if;
    update notas set situacao = v_resultado where nome_materia = v_nome_materia;
    
    v_nome_materia := 'Java';
    select media into v_media from notas where nome_materia = v_nome_materia;
    if v_media >= 7.0 then 
        v_resultado := 'A';
    elsif (v_media >= 5.0 or v_media <= 6.9) then
        v_resultado := 'Ex';
    else
        v_resultado := 'Rec';
    end if;
    update notas set situacao = v_resultado where nome_materia = v_nome_materia;
end;

select * from notas;

BEGIN
  FOR cur_rec IN (SELECT table_name FROM user_tables) LOOP
    EXECUTE IMMEDIATE 'DROP TABLE ' || cur_rec.table_name || ' CASCADE CONSTRAINTS';
  END LOOP;
END;

declare 
    v_contador number(2) := 0;
begin
    loop
        dbms_output.put_line(v_contador);
        v_contador := v_contador + 1;
        exit when v_contador > 20;
    end loop;
end;

declare 
    v_contador number(2) := 0;
begin
    for v_contador in reverse 1..20 loop
        dbms_output.put_line(v_contador);
    end loop;
end;

-- ex1: processamento de uma tabuada

declare 
    v_contador number(2) := 0;
    v_tabuada number := &vi_tabuada;
begin
    for v_contador in 1..10 loop
        dbms_output.put_line(v_tabuada || 'x' || v_contador || ': ' || (v_tabuada * v_contador));
    end loop;
end;

-- ex2: quantidade de par e impar em um intervalo

declare 
    v_contador number := 0;
    v_intervalo v_contador%type := &vi_intervalo;
    v_par v_contador%type := 0;
    v_impar v_contador%type := 0;
begin
    for v_contador in 1..v_intervalo loop
        if mod(v_contador, 2) = 0 then
            v_par := v_par + 1;
        else 
            v_impar := v_impar + 1;
        end if;
    end loop;
    dbms_output.put_line('Quantidade de pares: ' || v_par);
    dbms_output.put_line('Quantidade de impares: ' || v_impar);
end;

-- ex3: media dos valores pares e soma dos impares em um intervalo 

declare 
    v_contador number := 0;
    v_intervalo v_contador%type := &vi_intervalo;
    v_par v_contador%type := 0;
    v_quantidade_par v_contador%type := 0;
    v_impar v_contador%type := 0;
begin
    for v_contador in 1..v_intervalo loop
        if mod(v_contador, 2) = 0 then
            v_par := v_par + v_contador;
            v_quantidade_par := v_quantidade_par + 1;
        else 
            v_impar := v_contador + v_impar;
        end if;
    end loop;
    dbms_output.put_line('Media de valores pares: ' || (v_par / v_quantidade_par));
    dbms_output.put_line('Soma de impares: ' || v_impar);
end;