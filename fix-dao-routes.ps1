# Script para padronizar rotas dos DAOs
$daoPath = "C:\gcomp-sistema\GestorGcomp\src\main\java\com\devpampa\gcomp\dao"

Write-Host "Corrigindo rotas dos DAOs..." -ForegroundColor Cyan

$filesChanged = 0

Get-ChildItem -Path $daoPath -Filter "Dao*.java" | ForEach-Object {
    $file = $_.FullName
    $content = Get-Content -Path $file -Raw
    $changed = $false
    
    # Corrigir urlServicesUsuario
    if ($content -match 'urlServicesUsuario = "usuarios"') {
        $content = $content -replace 'urlServicesUsuario = "usuarios"', 'urlServicesUsuario = "/usuarios"'
        $changed = $true
        Write-Host "  OK $($_.Name): urlServicesUsuario" -ForegroundColor Green
    }
    
    # Corrigir urlServicesCategoriaNode
    if ($content -match 'urlServicesCategoriaNode = "categorias"') {
        $content = $content -replace 'urlServicesCategoriaNode = "categorias"', 'urlServicesCategoriaNode = "/categorias"'
        $changed = $true
        Write-Host "  OK $($_.Name): urlServicesCategoriaNode" -ForegroundColor Green
    }
    
    # Corrigir jogadores/buscarRGDisponivelCategoria
    if ($content -match '"jogadores/buscarRGDisponivelCategoria"') {
        $content = $content -replace '"jogadores/buscarRGDisponivelCategoria"', '"/jogadores/buscarRGDisponivelCategoria"'
        $changed = $true
        Write-Host "  OK $($_.Name): jogadores/buscarRGDisponivelCategoria" -ForegroundColor Green
    }
    
    # Corrigir jogadores/buscarRGDisponivelCompeticao
    if ($content -match '"jogadores/buscarRGDisponivelCompeticao"') {
        $content = $content -replace '"jogadores/buscarRGDisponivelCompeticao"', '"/jogadores/buscarRGDisponivelCompeticao"'
        $changed = $true
        Write-Host "  OK $($_.Name): jogadores/buscarRGDisponivelCompeticao" -ForegroundColor Green
    }
    
    if ($changed) {
        Set-Content -Path $file -Value $content -NoNewline
        $filesChanged++
    }
}

Write-Host ""
Write-Host "Concluido! $filesChanged arquivos modificados." -ForegroundColor Green
Write-Host ""
Write-Host "Proximos passos:" -ForegroundColor Yellow
Write-Host "1. Verifique: git diff" -ForegroundColor White
Write-Host "2. Teste a aplicacao" -ForegroundColor White
Write-Host "3. Commit: git add . && git commit -m 'fix: padronizar rotas dos DAOs'" -ForegroundColor White
Write-Host "4. No .env use: URL_NODE=http://gcomp-backend-node:3003/api" -ForegroundColor White
