# 🌐 Desafio_BANCO_DE_DADOS---TRIGGERS
Scripts SQL com consultas, views otimizadas, controle de acesso e triggers para automação e integridade dos dados.

## 📊 Views implementadas
- `numero_de_funcionarios_por_departament_localidade`
- `departamento_e_seus_gerentes`
- `Quantidade_de_empregados_por_projeto`
- `projetos_departamentos_e_gerentes`
- `gerentes_que_possuem_dependentes`

## 🔐 Controle de Acesso
- Usuário `gerente`: acesso total
- Usuário `funcionario`: acesso restrito a views

## ⚙️ Triggers implementadas
- `insercao_de_funcionario`: ajusta salário conforme Dno
- `Remocao_de_funcionario`: backup antes da exclusão


## 🚀 Como Executar
1. Execute os scripts de criação de views para otimizar o acesso aos dados , facilitando as análises e relatórios.
2. Crie e gerencie os usuários com permissões específicas (gerente, funcionario) para garantir a segurança e o controle de privilégios no banco de dados.
3. Automatize comportamentos como atribuição de supervisores, reajuste salarial e backup antes de exclusão de funcionários.
4. Modifique e expanda conforme necessidade do seu projeto ou análise.
