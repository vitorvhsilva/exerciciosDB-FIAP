CREATE TABLE TB_ALUNO (
    id_aluno INT NOT NULL,
    nome_aluno VARCHAR2(100),
    CONSTRAINT tb_aluno_id_aluno_pk PRIMARY KEY(id_aluno)
);

CREATE TABLE TB_CONTATO (
    id_aluno INT NOT NULL,
    telefone INT,
    email VARCHAR2(50),
    CONSTRAINT tb_contrato_id_aluno_fk FOREIGN KEY(id_aluno)
        REFERENCES TB_ALUNO(id_aluno)
);

CREATE TABLE TB_LOGIN (
    id_aluno INT NOT NULL,
    senha VARCHAR2(100),
    turno VARCHAR2(15),
    CONSTRAINT tb_login_id_aluno_pk PRIMARY KEY(id_aluno),
    CONSTRAINT tb_login_id_aluno_fk FOREIGN KEY(id_aluno)
        REFERENCES TB_ALUNO(id_aluno)
);

CREATE TABLE TB_CURSO (
    id_curso INT NOT NULL,
    nome_curso VARCHAR2(100),
    CONSTRAINT tb_curso_id_aluno_pk PRIMARY KEY(id_curso)
);

CREATE TABLE TB_TURMA (
    id_aluno INT NOT NULL,
    id_curso INT NOT NULL,
    CONSTRAINT tb_turma_id_aluno_fk FOREIGN KEY(id_aluno)
        REFERENCES TB_ALUNO(id_aluno),
    CONSTRAINT tb_turma_id_curso_fk FOREIGN KEY(id_curso)
        REFERENCES TB_CURSO(id_curso)
);

INSERT INTO TB_ALUNO(id_aluno, nome_aluno) VALUES (1, 'Isa');
INSERT INTO TB_ALUNO(id_aluno, nome_aluno) VALUES (2, 'Vitor');
INSERT INTO TB_ALUNO(id_aluno, nome_aluno) VALUES (3, 'Silvio');

INSERT INTO TB_CONTATO(id_aluno, telefone, email) VALUES (1, 11987321563, 'isa@email.com');
INSERT INTO TB_CONTATO(id_aluno, telefone, email) VALUES (2, 11982172114, 'vitor@email.com');
INSERT INTO TB_CONTATO(id_aluno, telefone, email) VALUES (3, 11938123896, 'silvio@email.com');

INSERT INTO TB_LOGIN(id_aluno, senha, turno) VALUES (1, 'silviolindo', 'manha');
INSERT INTO TB_LOGIN(id_aluno, senha, turno) VALUES (2, 'silviolindo', 'tarde');
INSERT INTO TB_LOGIN(id_aluno, senha, turno) VALUES (3, 'silviolindo', 'noite');

INSERT INTO TB_CURSO(id_curso, nome_curso) VALUES (1, 'matemática');
INSERT INTO TB_CURSO(id_curso, nome_curso) VALUES (2, 'português');
INSERT INTO TB_CURSO(id_curso, nome_curso) VALUES (3, 'química');

INSERT INTO TB_TURMA(id_aluno, id_curso) VALUES (1, 1);
INSERT INTO TB_TURMA(id_aluno, id_curso) VALUES (2, 1);
INSERT INTO TB_TURMA(id_aluno, id_curso) VALUES (3, 1);
INSERT INTO TB_TURMA(id_aluno, id_curso) VALUES (1, 2);
INSERT INTO TB_TURMA(id_aluno, id_curso) VALUES (2, 2);
INSERT INTO TB_TURMA(id_aluno, id_curso) VALUES (3, 2);
INSERT INTO TB_TURMA(id_aluno, id_curso) VALUES (2, 3);

CREATE SEQUENCE tb_aluno_id_aluno_seq START WITH 1 INCREMENT BY 1;

CREATE TRIGGER tb_aluno_id_aluno_trg BEFORE 
INSERT ON tb_aluno 
FOR EACH ROW 
WHEN (new.id_aluno IS NULL) 
    BEGIN 
        :new.id_aluno := tb_aluno_id_aluno_seq.nextval; 
    END;
    
CREATE SEQUENCE tb_contato_id_aluno_seq START WITH 1 INCREMENT BY 1;

CREATE TRIGGER tb_contato_id_aluno_trg BEFORE 
INSERT ON tb_contato 
FOR EACH ROW 
WHEN (new.id_aluno IS NULL) 
    BEGIN 
        :new.id_aluno := tb_contato_id_aluno_seq.nextval; 
    END;

CREATE SEQUENCE tb_login_id_aluno_seq START WITH 1 INCREMENT BY 1;

CREATE TRIGGER tb_login_id_aluno_trg BEFORE 
INSERT ON tb_login 
FOR EACH ROW 
WHEN (new.id_aluno IS NULL) 
    BEGIN 
        :new.id_aluno := tb_login_id_aluno_seq.nextval; 
    END;
    
CREATE SEQUENCE tb_curso_id_curso_seq START WITH 1 INCREMENT BY 1;

CREATE TRIGGER tb_curso_id_curso_trg BEFORE 
INSERT ON tb_curso
FOR EACH ROW 
WHEN (new.id_curso IS NULL) 
    BEGIN 
        :new.id_curso := tb_curso_id_curso_seq.nextval; 
    END;
    
INSERT INTO TB_ALUNO(nome_aluno) VALUES ('Brendon');

BEGIN
  FOR cur_rec IN (SELECT table_name FROM user_tables) LOOP
    EXECUTE IMMEDIATE 'DROP TABLE ' || cur_rec.table_name || ' CASCADE CONSTRAINTS';
  END LOOP;
END;

BEGIN
  FOR cur_rec IN (SELECT sequence_name FROM user_sequences) LOOP
    EXECUTE IMMEDIATE 'DROP SEQUENCE ' || cur_rec.sequence_name;
  END LOOP;
END;

BEGIN
  FOR cur_rec IN (SELECT trigger_name FROM user_triggers) LOOP
    EXECUTE IMMEDIATE 'DROP TRIGGER ' || cur_rec.trigger_name;
  END LOOP;
END;

