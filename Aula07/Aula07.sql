-- Aula 7 -  24+/02

set serveroutput on -- habilita a saída de dados

set verify off -- desabilita a verificação da vm   

create table aluno (
    ra char(2),
    nome varchar2(255),
    constraint aluno_pk primary key (ra)
);

insert into aluno (ra, nome) values ('11', 'Brendon de Paula');
insert into aluno (ra, nome) values ('22', 'Vitor Hugo');

declare
    v_ra char(2) := '1';
    v_nome varchar2(255);
begin
    select nome into v_nome from aluno where ra >= v_ra;
    dbms_output.put_line('O nome do aluno é: ' || v_nome);
end;

declare
    v_ra char(2) := '33';
    v_nome varchar2(255) := 'Ganança Irmãos';
begin
    insert into aluno (ra, nome) values (v_ra, v_nome);
end;

declare
    v_ra char(2) := '33';
    v_nome varchar2(255) := 'Mzp Irmãos';
begin
    update aluno set nome = v_nome where ra = v_ra;
end;

declare
    v_ra char(2) := '33';
begin
    delete from aluno where ra = v_ra;
end;

select * from aluno;

create table notas (
    rm varchar2(6),
    nome_materia varchar2(255),
    cp1 number,
    cp2 number,
    cp3 number,
    media number,
    situacao varchar2(3)
);

-- popular notas    
declare
    v_cp1 number;
    v_cp2 v_cp1%type;
    v_cp3 v_cp1%type;
    v_media v_cp1%type;
begin
    v_cp1 := 10; v_cp2 := 10; v_cp3 := 10; v_media := round(((v_cp1 + v_cp2 + v_cp3) / 3), 2); 
    insert into notas (rm, nome_materia, cp1, cp2, cp3, media) values  
        ('558961', 'BD', v_cp1, v_cp2, v_cp3, v_media);
        
    v_cp1 := 7.6; v_cp2 := 8.2; v_cp3 := 10; v_media := round(((v_cp1 + v_cp2 + v_cp3) / 3), 2); 
    insert into notas (rm, nome_materia, cp1, cp2, cp3, media) values  
        ('558961', 'IA', v_cp1, v_cp2, v_cp3, v_media);
        
    v_cp1 := 4.1; v_cp2 := 2.2; v_cp3 := 1.4; v_media := round(((v_cp1 + v_cp2 + v_cp3) / 3), 2); 
    insert into notas (rm, nome_materia, cp1, cp2, cp3, media) values  
        ('558961', 'Front', v_cp1, v_cp2, v_cp3, v_media);
        
    v_cp1 := 5.0; v_cp2 := 5.0; v_cp3 := 5.0; v_media := round(((v_cp1 + v_cp2 + v_cp3) / 3), 2);  
    insert into notas (rm, nome_materia, cp1, cp2, cp3, media) values  
        ('558961', 'Java', v_cp1, v_cp2, v_cp3, v_media);
end;

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