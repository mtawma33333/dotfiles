# 界面与操作习惯
Set-PSReadLineOption -PredictionViewStyle ListView -BellStyle None -EditMode vi
Set-PSReadLineKeyHandler -Key 'Ctrl+z' -Function Undo
Invoke-Expression (&starship init powershell)

# 模块
Import-Module PSCompletions

# 开发环境与跳转工具
(&mise activate pwsh) | Out-String | Invoke-Expression
zoxide init powershell | Out-String | Invoke-Expression