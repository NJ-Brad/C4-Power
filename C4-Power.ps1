Enum EntityType
{
	Person
	System
	EnterpriseBoundary
	Container
	ContainerBoundary
	SystemBoundary
	Component
	ComponentNode
	Boundary
	ContainerQueue
	ComponentQueue
}

class EntityCollection
{
    # Properties
	# Generic array - prevents circular definitions
    [object[]] $Children
	
    # Parameterless Constructor
    EntityCollection ()
    {
		$this.Children = $()
    }

    # ToString Method
#    [String] ToString()
#    {
#        return $this.Alias + ":" + $this.HitPoints
#    }

	[void] Add([object] $entity)
	{
		$this.Children += $entity
	} 
}

class Entity : EntityCollection
{
    # Properties
    [String] $Alias
	[String] $Label	
	[bool] $External	
	[bool] $Database	
	[String] $Technology	
	[String] $Description	
	[String] $Image
	[EntityType] $EntType
	[String] $DisplayedCmd
	[String] $ActualCommand
	[Bool] $AllowsChildren
	
#    [int32] $HitPoints

    # Static Properties
 #   static [String] $Clan = "DevOps Library"

    # Hidden Properties
#    hidden [String] $RealName

    # Parameterless Constructor
    Entity ()
    {
    }

    # Constructor
    Entity ([String] $Alias, 
		[string] $Label, 
		[bool] $External, 
		[bool] $Database, 
		[String] $Technology, 
		[String] $Description, 
		[String] $Image, 
		[EntityType] $EntType,
		[String] $DisplayedCmd,
		[String] $ActualCommand,
		[bool] $AllowsChildren
	)
    {
		if([string]::IsNullOrEmpty($Alias))
		{
			$this.Alias = ConvertLabelToAlias($Label)
		}
		else
		{
			$this.Alias = $Alias
		}
        $this.Label = $Label
		$this.External = $External	
		$this.Database = $Database	
		$this.Technology = $Technology
		$this.Description = $Description
		$this.Image = $Image
		$this.$EntType = $EntType
		$this.DisplayedCmd = $DisplayedCmd
		$this.ActualCommand = $ActualCommand
		$this.AllowsChildren = $AllowsChildren
    }

    # Method
#    [String] getAlias()
#    {
#       return $this.Alias
#    }
#
#    [String] getLabel()
#    {
#       return $this.Label
#    }
#
#	[bool] getExternal()
#	{
#		return $this.External
#	}
#	
#	[bool] getDatabase()
#	{
#		return $this.Database
#	}
#	
#	[String] $Technology	
#	[String] $Description	
#	[String] $Image

#    # Static Method
#    static [String] getClan()
#    {
#        return [CyberNinja]::Clan
#    }

    # ToString Method
#    [String] ToString()
#    {
#       return $this.Alias + ":" + $this.HitPoints
#    }

	[String]ConvertLabelToAlias([string] $Label)
	{
		[String]$rtnVal = $Label
		$rtnVal = $rtnVal.Replace(" ", "_")
		
		return $rtnVal
	}

    [String] ToPlantUmlString()
    {
		[string]$rtnVal = $this.ActualCommand
		
		if($this.Database)
		{
			$rtnVal += "Db"
		}
		
		if($this.External)
		{
			$rtnVal += "_Ext"
		}
		
		$rtnVal += "("
		
		# alias and label
		$rtnVal += $this.Alias +", " + [char]34 + $this.Label + [char]34
		
		if($this.Technology -ne "")
		{
			$rtnVal += ", " + [char]34 + $this.Technology + [char]34
		}
		
		if($this.Description -ne "")
		{
			$rtnVal += ", " + [char]34 + $this.Description + [char]34
		}

		if($this.Image -ne "")
		{
			$rtnVal += ", " + [char]34 + $this.Image + [char]34
		}
		
		$rtnVal += ")"

		if($this.AllowsChildren)
		{
			$rtnVal += "{`r`n"
		
			foreach($ent in $this.Children)
			{
				$rtnVal += $ent.ToPlantUmlString()
				$rtnVal += "`r`n"
			}		
		
			$rtnVal += "}"
		}
		
       return $rtnVal
    }
}

# https://xainey.github.io/2016/powershell-classes-and-concepts/
#
#[CyberNinja]::Clan
#
## Using Static "new" method.
#$Ken = [CyberNinja]::new("Ken", 28)
#
## Using New-Object. Parameters for Argument list are positional and required by the constructor.
#$Hodge = New-Object CyberNinja -ArgumentList "Hodge", 31
#
## Using a HashTable. Note: requires default or parameterless constructor.
#$June = [CyberNinja]@{
#    Alias = "June";
#    HitPoints = 40;
#}
#
## Dynamic Object Type using a variable name.
#$Type = "CyberNinja"
#$Steven = New-Object -TypeName $Type

class Connection
{
	[String]$From
	[String]$To
	[String]$Label
	[String]$Technology
	
    [String] ToPlantUmlString()
    {
		[string]$rtnVal = "Rel($($this.From), $($this.To), "
		$rtnVal += [char]34 + $this.Label + [char]34
		$rtnVal += ", " + [char]34 + $this.Technology + [char]34 + ")"
		
       return $rtnVal
    }
}

# https://xainey.github.io/2016/powershell-classes-and-concepts/
# https://xainey.github.io/2016/powershell-classes-and-concepts/#singleton

class Workspace
{
    # Instanced Properties

 	# The ID of the workspace. 
	[String] $Id

    # The name of the workspace.
    [String] $Name

    # A short description of the workspace.
    [String] $Description

	# The last modified date of the workspace.
	[DateTime] $LastModifiedDate

	# The name of the user who last modified this workspace (e.g. a username).
	[String] $LastModifiedUser

	# The name of the agent that was used to last modify this workspace (e.g. "Structurizr for .NET").
	[String] $LastModifiedAgent

	# The version of the workspace.
	[String] $Version

	# The revision number of the workspace.
	[long] $Revision

	# The thumbnail associated with the workspace; a Base64 encoded PNG file as a Data URI (data:image/png;base64).
	# <value>The thumbnail associated with the workspace; a Base64 encoded PNG file as a Data URI (data:image/png;base64).</value>
	[String] $Thumbnail
	
	
	[string]$DiagramType
	[string] $Title
	[bool] $Sketch
	[bool] $Legend
	[bool] $TopDown
	

	# unknown now
	#public WorkspaceConfiguration Configuration { get; set; }

	[EntityCollection] $Entities
	
	[System.Collections.Generic.Stack[Entity]] $Hierarchy
#	$Hierarchy = New-Object System.Collections.Generic.Stack[Model] 

	[Connection[]] $Connections

#$stack.Push("Booger")
#
#if($stack.Count -gt 0)
#{
#    $stack.Pop()
#}
#else
#{
#    "Stack is empty"
#}
	
	
    static [Workspace] $instance

    static [Workspace] GetInstance()
    {
        if ([Workspace]::instance -eq $null)
        {
            [Workspace] $ws = [Workspace]::new()
            # [UniqueName]::instance = [UniqueName]::new()
            [Workspace]::instance = $ws
			$ws.Hierarchy = New-Object System.Collections.Generic.Stack[Entity] 			
			$ws.Entities = [EntityCollection]::new()
			$ws.Connections = @()
        }

        return [Workspace]::instance
    }
#	static [bool] IsUnique([string] $Candidate)
#	{
#		[bool]$rtnVal = $False
#		
#		[UniqueName] $isu = [UniqueName]::GetInstance()
#		if($isu.Names -contains $Candidate)
#		{
#			$rtnVal = $False
#		}
#		else
#		{
#			$rtnVal = $True
#			$isu.Names += $Candidate
#		}
#		
#		return $rtnVal
#	}

    [String] ToPlantUmlString()
    {
# !include https://raw.githubusercontent.com/plantuml-stdlib/C4-PlantUML/master/C4_Container.puml
# !include https://raw.githubusercontent.com/plantuml-stdlib/C4-PlantUML/master/C4_Context.puml
		
		[string]$rtnVal = @"
@startuml 
!include https://raw.githubusercontent.com/plantuml-stdlib/C4-PlantUML/master/C4_$($this.DiagramType).puml

!define DEVICONS https://raw.githubusercontent.com/tupadr3/plantuml-icon-font-sprites/master/devicons
!define FONTAWESOME https://raw.githubusercontent.com/tupadr3/plantuml-icon-font-sprites/master/font-awesome-5

!include DEVICONS/angular.puml
!include DEVICONS/dotnet.puml
!include DEVICONS/java.puml
!include DEVICONS/msql_server.puml
!include FONTAWESOME/server.puml
!include FONTAWESOME/envelope.puml
"@
		$rtnVal += "`r`ntitle " + $this.Title + "`r`n"
		if($this.Sketch)
		{
			$rtnVal += "LAYOUT_AS_SKETCH()`r`n"
		}
		
		if($this.Legend)
		{
			$rtnVal += "LAYOUT_WITH_LEGEND()`r`n"
		}
		
		if($this.TopDown)
		{
			$rtnVal += "LAYOUT_TOP_DOWN()`r`n"
		}
		else
		{
			$rtnVal += "LAYOUT_LEFT_RIGHT()`r`n"
		}
	

		foreach($ent in $this.Entities.Children)
		{
			$rtnVal += $ent.ToPlantUmlString()
			$rtnVal += "`r`n"
		}

		foreach($conn in $this.Connections)
		{
			$rtnVal += $conn.ToPlantUmlString()
			$rtnVal += "`r`n"
		}

		$rtnVal += "@enduml"

		return $rtnVal
	}
}
# https://plantuml.com/server
# Address ... /plantuml/png/[ENCODED DATA]

# https://plantuml.com/text-encoding


# From: https://github.com/alexbestul/posh-plantuml-urls/blob/master/Posh-Plantuml-Urls.psm1
# https://www.powershellgallery.com/packages/posh-plantuml-urls/0.2

function Encode6Bit($b) {
    if ($b -lt 10) { return [char](48 + $b) }
    $b -= 10
    if ($b -lt 26) { return [char](65 + $b) }
    $b -= 26
    if ($b -lt 26) { return [char](97 + $b) }
    $b -= 26
    if ($b -eq 0) { return '-' }
    if ($b -eq 1) { return '_' }
    return '?'
}

function Append3Bytes($b1, $b2, $b3) {
    $c1 = $b1 -shr 2
    $c2 = (($b1 -band 0x3) -shl 4) -bor ($b2 -shr 4)
    $c3 = (($b2 -band 0xF) -shl 2) -bor ($b3 -shr 6)
    $c4 = $b3 -band 0x3F

    # [convert]::ToString($b1, 2) + "" + [convert]::ToString($b2, 2) + "" + [convert]::ToString($b3, 2)
    # [convert]::ToString($c1, 2) + "" + [convert]::ToString($c2, 2) + "" + [convert]::ToString($c3, 2) + "" + [convert]::ToString($c4, 2)

    $r = ""
    $r += Encode6Bit ($c1 -band 0x3F)
    $r += Encode6Bit ($c2 -band 0x3F)
    $r += Encode6Bit ($c3 -band 0x3F)
    $r += Encode6Bit ($c4 -band 0x3F)

    return $r
}

function Encode64($data) {
    $r = ""

    For ($i = 0; $i -lt $data.Length; $i += 3) {
        If (($i+2) -eq $data.Length) {
            $r += Append3Bytes $data[$i] $data[$i+1] 0
        } ElseIf (($i+1) -eq $data.Length) {
            $r += Append3Bytes $data[$i] 0 0
        } Else {
            $r += Append3Bytes $data[$i] $data[$i+1] $data[$i+2]
        }
    }

    return $r
}

function Deflate($text) {
    $data = [System.Text.Encoding]::UTF8.GetBytes($text)

    $sourceStream = [System.IO.MemoryStream]::new($data)
    $destStream = [IO.MemoryStream]::new()
    $compressionStream = [System.IO.Compression.DeflateStream]::new($destStream, [IO.Compression.CompressionMode]::Compress)
    $sourceStream.CopyTo($compressionStream)
    $compressionStream.Dispose()

    return $destStream.ToArray()
}

<#
.SYNOPSIS
Encodes text into PlantUml's base64-like URL format.
.PARAMETER plantUml
The text to be encoded.
.EXAMPLE
ConvertTo-EncodedPlantUml "Alice-->Bob:Hello"
.EXAMPLE
"Alice-->Bob:Hello" | ConvertTo-EncodedPlantUml
.EXAMPLE
Get-Content example.puml | ConvertTo-EncodedPlantUml
#>
Function ConvertTo-EncodedPlantUml {
    Param(
        [Parameter(ValueFromPipeline=$True,ValueFromPipelinebyPropertyName=$True)]
        [String]
        $plantUml
    )
    
    $compressedText = Deflate $plantUml
    Encode64 $compressedText
}# helper functions

function New-Entity
{
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory=$true, Position=0)]
        [EntityType]$enttype,
		
        [Parameter(Mandatory=$true, Position=1)]
        [string]$Label,

        [Parameter(Mandatory=$false, Position=2)]
        [string]$Alias,

		[bool] $External, 
		[bool] $Database, 
		[String] $Technology, 
		[String] $Description, 
		[String] $Image, 
		[String] $DisplayedCmd,
		[String] $ActualCommand,
		[bool] $AllowsChildren
    )

	[Entity]$rtnVal = [Entity]::new();

	if([string]::IsNullOrEmpty($Alias ))
	{
		$rtnVal.Alias = ConvertTo-Alias($Label)
	}
	else
	{
		$rtnVal.Alias = ConvertTo-Alias($Alias)
	}

	$rtnVal.Label = $Label
	$rtnVal.External = $External	
	$rtnVal.Database = $Database	
	$rtnVal.Technology = $Technology
	$rtnVal.Description = $Description
	$rtnVal.Image = $Image
	$rtnVal.EntType = $EntType
	$rtnVal.DisplayedCmd = $DisplayedCmd
	$rtnVal.ActualCommand = $ActualCommand
	$rtnVal.AllowsChildren = $AllowsChildren

	$ws = [Workspace]::GetInstance()
	
	if($ws.Hierarchy.Count -ne 0)
	{
		$ws.Hierarchy.Peek().Add($rtnVal)
	}
	else
	{
		$ws.Entities.Add($rtnVal)
	}
	
    return $rtnVal
}

function ConvertTo-Alias
{
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory=$true, Position=0)]
        [string]$Label
    )

	[String]$rtnVal = $Label
	$rtnVal = $rtnVal.Replace(" ", "_")
		
	return $rtnVal
}


function New-Person
{
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory=$true, Position=0)]
        [string]$Label,

        [Parameter(Mandatory=$false, Position=1)]
        [string]$Alias,

		[bool] $External, 
		[String] $Description
    )
	return New-Entity ([EntityType]::Person) $Label $Alias `
		-External $External `
		-Description $Description `
		-DisplayedCmd "Person" `
		-ActualCommand "Person" `
		-AllowsChildren $False
}

function New-System
{
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory=$true, Position=0)]
        [string]$Label,

        [Parameter(Mandatory=$false, Position=1)]
        [string]$Alias,

		[bool] $External, 
		[String] $Description, 
		[String] $Image

    )
	return New-Entity ([EntityType]::System) $Label $Alias `
		-External $External `
		-Description $Description `
		-Image $Image `
		-DisplayedCmd "System" `
		-ActualCommand "System" `
		-AllowsChildren $False
}

function New-Container
{
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory=$true, Position=0)]
        [string]$Label,

        [Parameter(Mandatory=$false, Position=1)]
        [string]$Alias,

		[bool] $External, 
		[bool] $Database, 
		[String] $Technology, 
		[String] $Description, 
		[String] $Image

    )
	
	$rtnVal = New-Entity ([EntityType]::Container) $Label $Alias `
		-External $External `
		-Database $Database `
		-Technology $Technology `
		-Description $Description `
		-Image $Image `
		-DisplayedCmd "Container" `
		-ActualCommand "Container" `
		-AllowsChildren $False
		
	return $rtnVal
}

function New-Boundary
{
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory=$true, Position=0)]
        [string]$Label,

        [Parameter(Mandatory=$false, Position=1)]
        [string]$Alias,
		
		[String] $Technology

    )
	
	$rtnVal = New-Entity ([EntityType]::Boundary) $Label $Alias `
		-Technology $Technology `
		-DisplayedCmd "Boundary" `
		-ActualCommand "Boundary" `
		-AllowsChildren $True
		
	$ws = [Workspace]::GetInstance()
	$ws.Hierarchy.Push($rtnVal)

	return $rtnVal
}

function New-EnterpriseBoundary
{
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory=$true, Position=0)]
        [string]$Label,

        [Parameter(Mandatory=$false, Position=1)]
        [string]$Alias

    )
	$rtnVal = New-Entity ([EntityType]::EnterpriseBoundary) $Label $Alias `
		-DisplayedCmd "Enterprise Boundary" `
		-ActualCommand "Enterprise_Boundary" `
		-AllowsChildren $True

	$ws = [Workspace]::GetInstance()
	$ws.Hierarchy.Push($rtnVal)

	return $rtnVal
}

function New-ContainerBoundary
{
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory=$true, Position=0)]
        [string]$Label,

        [Parameter(Mandatory=$false, Position=1)]
        [string]$Alias

    )
	$rtnVal = New-Entity ([EntityType]::ContainerBoundary) $Label $Alias `
		-DisplayedCmd "Container Boundary" `
		-ActualCommand "Container_Boundary" `
		-AllowsChildren $True

	$ws = [Workspace]::GetInstance()
	$ws.Hierarchy.Push($rtnVal)

	return $rtnVal
}

function New-SystemBoundary
{
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory=$true, Position=0)]
        [string]$Label,

        [Parameter(Mandatory=$false, Position=1)]
        [string]$Alias

    )
	$rtnVal = New-Entity ([EntityType]::SystemBoundary) $Label $Alias `
		-DisplayedCmd "System Boundary" `
		-ActualCommand "System_Boundary" `
		-AllowsChildren $True
		
	$ws = [Workspace]::GetInstance()
	$ws.Hierarchy.Push($rtnVal)

	return $rtnVal
}

function Close-Boundary
{
	$ws = [Workspace]::GetInstance()
	$ws.Hierarchy.Pop()

	return $rtnVal
}

function New-Component
{
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory=$true, Position=0)]
        [string]$Label,

        [Parameter(Mandatory=$false, Position=1)]
        [string]$Alias,
		
		[bool] $Database, 
		[String] $Technology, 
		[String] $Description, 
		[String] $Image

    )
	return New-Entity ([EntityType]::Component) $Label $Alias `
		-Database $Database `
		-Technology $Technology `
		-Description $Description `
		-Image $Image `
		-DisplayedCmd "Component" `
		-ActualCommand "Component" `
		-AllowsChildren $True
}

function New-ComponentNode
{
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory=$true, Position=0)]
        [string]$Label,

        [Parameter(Mandatory=$false, Position=1)]
        [string]$Alias,
		
		[bool] $External, 
		[bool] $Database, 
		[String] $Technology, 
		[String] $Description, 
		[String] $Image

    )
	return New-Entity ([EntityType]::ComponentNode) $Label $Alias `
		-External $External `
		-Database $Database `
		-Technology $Technology `
		-Description $Description `
		-Image $Image `
		-DisplayedCmd "Component Node" `
		-ActualCommand "Component_Node" `
		-AllowsChildren $False
}

function New-ContainerQueue
{
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory=$true, Position=0)]
        [string]$Label,

        [Parameter(Mandatory=$false, Position=1)]
        [string]$Alias,
		
		[bool] $External, 
		[String] $Technology, 
		[String] $Description, 
		[String] $Image

    )
	return New-Entity ([EntityType]::ContainerQueue) $Label $Alias `
		-External $External `
		-Technology $Technology `
		-Description $Description `
		-Image $Image `
		-DisplayedCmd "Container Queue" `
		-ActualCommand "Container_Queue" `
		-AllowsChildren $False
}

function New-ContainerQueue
{
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory=$true, Position=0)]
        [string]$Label,

        [Parameter(Mandatory=$false, Position=1)]
        [string]$Alias,
		
		[bool] $External, 
		[String] $Technology, 
		[String] $Description, 
		[String] $Image

    )
	return New-Entity ([EntityType]::ComponentQueue) $Label $Alias `
		-External $External `
		-Technology $Technology `
		-Description $Description `
		-Image $Image `
		-DisplayedCmd "Component Queue" `
		-ActualCommand "Component_Queue" `
		-AllowsChildren $False
}

function Publish-View
{
    [CmdletBinding()]
    Param
    (
        [bool]$ViewInEditor
		
        #[string]$To,
		#[String] $Label,
		#[String] $Technology
    )
	
	$ws = [Workspace]::GetInstance()
	$plantUml = $ws.ToPlantUmlString()
#	$plantUml
	$encoded = ConvertTo-EncodedPlantUml($plantUml)
	
	if($ViewInEditor)
	{
		$address = "http://plantuml.com/plantuml/uml/$encoded"
	}
	else
	{
		$address = "http://plantuml.com/plantuml/png/$encoded"
	}
	
	# https://stackoverflow.com/questions/51225598/downloading-a-file-with-powershell
#	$address
	# this should open the file in the browser
	Start-Process $address
# this will generate a file, then open it
#	$Response = Invoke-WebRequest -URI $address -OutFile .\image.png
#	Start-Process .\image.png
}

function New-Connection
{
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory=$true, Position=0)]
        [string]$From,
		
        [Parameter(Mandatory=$true, Position=1)]
        [string]$To,
		[String] $Label,
		[String] $Technology
    )

	[Connection]$rtnVal = [Connection]::new();

	$rtnVal.From = ConvertTo-Alias($From)
	$rtnVal.To = ConvertTo-Alias($To)
	$rtnVal.Label = $Label
	$rtnVal.Technology = $Technology

	$ws = [Workspace]::GetInstance()
	
	$ws.Connections += $rtnVal
	
    return $rtnVal
}

function Initialize-Workspace
{
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory=$true, Position=0)]
        [string]$DiagramType,
		
        [string]$Name,
		[string] $Title,
		[string] $Description,
		[bool] $Sketch,
		[bool] $Legend,
		[bool] $TopDown
    )
	
	$ws = [Workspace]::GetInstance()
	$ws.Hierarchy = New-Object System.Collections.Generic.Stack[Entity] 			
	$ws.Entities = [EntityCollection]::new()
	$ws.Connections = @()
	$ws.DiagramType = $DiagramType
	$ws.Name = $Name
	$ws.Title = $Title
	$ws.Description = $Description
	$ws.Sketch = $Sketch
	$ws.Legend = $Legend
	$ws.TopDown = $TopDown
}



# $ent = New-Entity -arg2 "Two" -arg1 "One" -arg3 ([EntityType]::Container)

#$ent

#$ws = [Workspace]::GetInstance()
#$ws.Entities.Children[0]