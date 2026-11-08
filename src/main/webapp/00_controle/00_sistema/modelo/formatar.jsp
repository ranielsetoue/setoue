<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
    
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    
    <style>
        .btn-adicionar {
            background-color: #28a745;
            border-color: #28a745;
            color: white;
            font-weight: 500;
        }
        
        .btn-adicionar:hover {
            background-color: #218838;
            border-color: #1e7e34;
            color: white;
        }
        
        .shortcut {
            font-size: 0.85em;
            opacity: 0.9;
            margin-left: 5px;
        }
    </style>
</head>
<body>

    <div class="container mt-5">
        <!-- Opção 1: Com Bootstrap Icons -->
        <button class="btn btn-adicionar">
            <i class="bi bi-plus-lg"></i> Adicionar outro item <span class="shortcut">(Alt+Z)</span>
        </button>
        
        <br><br>
        
        <!-- Opção 2: Usando btn-success padrão -->
        <button class="btn btn-success">
            <i class="bi bi-plus-lg"></i> Adicionar outro item <span class="shortcut">(Alt+Z)</span>
        </button>
        
        <br><br>
        
        <!-- Opção 3: Versão simplificada -->
        <button class="btn btn-success btn-sm">
            <i class="bi bi-plus"></i> Adicionar outro item (Alt+Z)
        </button>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>