# Load the System.Windows.Forms assembly into PowerShell
Add-Type -AssemblyName System.Windows.Forms

# Create a new Form object and assign to the variable $Form
    $Form = New-Object System.Windows.Forms.Form
    $Form.Text = "System Removal Tool"
    $Icon = [system.drawing.icon]::ExtractAssociatedIcon($PSHOME + "\powershell.exe")
    $Form.Icon = $Icon

# Font styles are: Regular, Bold, Italic, Underline, Strikeout
    $Font = New-Object System.Drawing.Font("Segoe UI",12,[System.Drawing.FontStyle]::Regular)
    $Form.Font = $Font
    $Label = New-Object System.Windows.Forms.Label
    $Label.Text = "Please enter the system name below:"
    $Label.BackColor = "Transparent"
    $Label.AutoSize = $True
# Allow user to resize too vs "GrowAndShrink" - user cannot resize
    $Form.AutoSizeMode = "GrowOnly"
    $Form.Controls.Add($Label)
    $form.Topmost = $true
    $form.Add_Shown({$textBox.Select()})
    $textBox = New-Object System.Windows.Forms.TextBox
    $textBox.Location = New-Object System.Drawing.Point(10,40)
#$textBox.Size = New-Object System.Drawing.Size(260,20)
    $form.Controls.Add($textBox)

#Initialize the "OK" Button
$OKButton = New-Object System.Windows.Forms.Button
$OKButton.Location = New-Object System.Drawing.Point(75,120)
$OKButton.Size = New-Object System.Drawing.Size(75,23)
$OKButton.Text = 'OK'
$OKButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
$form.AcceptButton = $OKButton
$form.Controls.Add($OKButton)

#Initialize the "Cancel" Button
$CancelButton = New-Object System.Windows.Forms.Button
$CancelButton.Location = New-Object System.Drawing.Point(150,120)
$CancelButton.Size = New-Object System.Drawing.Size(75,23)
$CancelButton.Text = 'Cancel'
$CancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
$form.CancelButton = $CancelButton
$form.Controls.Add($CancelButton)



#Initialize Form so it can be seen
$result = $form.ShowDialog()
