@PowerShell -ExecutionPolicy Bypass -Command Invoke-Expression $('$args=@(^&{$args} %*);'+[String]::Join(';',(Get-Content '%~f0') -notmatch '^^@PowerShell.*EOF$')) & goto :EOF

echo "        /######                                     /##    /##/##             "
echo "       /##__  ##                                   | ##   | #|__/             "
echo "      | ##  \__/ /######  /######  /####### /######| ##   | ##/##/######/#### "
echo "      |  ###### /##__  ##|____  ##/##_____//##__  #|  ## / ##| #| ##_  ##_  ##"
echo "       \____  #| ##  \ ## /######| ##     | ########\  ## ##/| #| ## \ ## \ ##"
echo "       /##  \ #| ##  | ##/##__  #| ##     | ##_____/ \  ###/ | #| ## | ## | ##"
echo "      |  ######| #######|  ######|  ######|  #######  \  #/  | #| ## | ## | ##"
echo "       \______/| ##____/ \_______/\_______/\_______/   \_/   |__|__/ |__/ |__/"
echo "               | ##                                                           "
echo "               | ##                                                           "
echo "               |__/                                                           "
echo "                    version : 0.9.0-dev  Zh_CN org : https://spacevim.org/cn/     "

Push-Location ~

$app_name    = "SpaceVim"
$repo_url    = "https://github.com/SpaceVim/SpaceVim.git"
$repo_name   = "SpaceVim"
$repo_path   = "$HOME\.SpaceVim"

Function Pause ($Message = "Press AnyKey to Continnue . . . ") {
  if ((Test-Path variable:psISE) -and $psISE) {
    $Shell = New-Object -ComObject "WScript.Shell"
      $Button = $Shell.Popup("Click OK to continue.", 0, "Script Paused", 0)
  } else {     
    Write-Host -NoNewline $Message
      [void][System.Console]::ReadKey($true)
      Write-Host
  }
}

echo "==> Being to find Environment Denpendency..."
echo ""
sleep 1


echo "==> test git Command"
if (Get-Command "git" -ErrorAction SilentlyContinue) {
  git version
  echo "[OK] Success. Start next Command..."
  sleep 1
} else {
  echo ""
  echo "Can not Get PATH about 'git.exe' Command"
  echo ">>> Ready to exit......"
  Pause
  exit
}

echo ""

echo "==> Test gvim Command"
if (Get-Command "gvim" -ErrorAction SilentlyContinue) {
  echo ($(vim --version) -split '\n')[0]
  echo "[OK] Success. The Next..."
  sleep 1
} else {
  echo "[WARNING] Con not From PATH find 'gvim.exe' Command. But continue install..."
  echo ""
  echo "[WARNING] Please install gvim or change PATH! "
  Pause
}

echo "<== Environment Denpendency Success. The Next..."
sleep 1
echo ""
echo ""

if (!(Test-Path "$HOME\.SpaceVim")) {
  echo "==> installing $app_name"
  git clone $repo_url $repo_path
} else {
  echo "==> Upadating $app_name"
  Push-Location $repo_path
  git pull origin master
}

echo ""
if (!(Test-Path "$HOME\vimfiles")) {
  cmd /c mklink $HOME\vimfiles $repo_path
  echo "[OK] 已为 vim 安装 SpaceVim"
  sleep 1
} else {
  echo "[OK] $HOME\vimfiles 已存在"
  sleep 1
}

echo ""
if (!(Test-Path "$HOME\AppData\Local\nvim")) {
  cmd /c mklink $HOME\AppData\Local\nvim $repo_path
  echo "[OK] 已为 neovim 安装 SpaceVim"
  sleep 1
} else {
  echo "[OK] $HOME\AppData\Local\nvim 已存在"
  sleep 1
}

echo ""
echo "Success install!"
echo "=============================================================================="
echo "==         Open Vim or Neovim，Every Plugins will Auto-install              =="
echo "=============================================================================="
echo ""
echo "Thanks Support SpaceVim，Welcome to Contact！"
echo ""

Pause

# vim:set ft=ps1 nowrap: 
