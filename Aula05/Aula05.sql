-- Aula 5 -  10/02

set serveroutput on -- habilita a saída de dados

set verify on -- desabilita a verificação da vm

begin
    dbms_output.put_line('Bom dia!');
end;

begin
    dbms_output.put_line('Novo salário R$ '|| 1212 * 1.25);
end;

declare 
    v_sal_min number(10, 2) := 1212;
    v_sal_reaj number(10, 2);
begin
    v_sal_reaj := v_sal_min * 1.25;
    dbms_output.put_line('Novo salário R$ '|| v_sal_reaj);
end;

-- Criar um bloco PL-SQL para calcular o valor em REAIS em 45 dólares

declare 
    v_dol number(10, 2) := &v_cota;
    v_real v_dol%type;
begin
    v_real := 45 * v_dol;
    dbms_output.put_line('Valor em Dólar: ' ||v_real);
end;

declare 
    v_carro number(10, 2) := &vi_carro;
    v_parcela_carro v_carro%type;
    v_carro_juros v_carro%type;
begin
    v_carro_juros := v_carro * 1.03;
    v_parcela_carro := v_carro_juros / 10;
    dbms_output.put_line('Valor de cada parcela do Carro: ' ||v_parcela_carro);
end;

declare 
    v_carro number(10, 2) := &vi_carro;
    v_entrada_carro v_carro%type;
    v_restante_carro v_carro%type;
begin
    v_entrada_carro := v_carro * 0.20;
    v_restante_carro := v_carro - v_entrada_carro;
    dbms_output.put_line('Valor em 6 parcelas: ' ||(v_restante_carro * 1.1) / 6);
    dbms_output.put_line('Valor em 12 parcelas: ' ||(v_restante_carro * 1.15) / 12);
    dbms_output.put_line('Valor em 18 parcelas: ' ||(v_restante_carro * 1.2) / 18);
end;