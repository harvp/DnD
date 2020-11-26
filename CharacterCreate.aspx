<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CharacterCreate.aspx.cs" Inherits="DnD.CharacterCreate" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        
        #Select1 {
            width: 225px;
        }
        #Text1 {
            width: 215px;
        }
        #Select2 {
            width: 225px;
        }
        #Select3 {
            width: 225px;
        }
        #Select4 {
            width: 225px;
        }
        #Select5 {
            width: 225px;
        }
        #Select6 {
            width: 225px;
        }
        #Select7 {
            width: 225px;
        }
        #Select8 {
            width: 225px;
        }
        #nameField {
            width: 274px;
        }
        #raceSelect {
            width: 282px;
        }
        #classSelect {
            width: 293px;
        }
        #alignmentSelect {
            width: 297px;
        }
        #levelSelect {
            width: 302px;
        }
        #subclass {
            width: 296px;
        }
        #feats {
            width: 304px;
        }
        #armor {
            width: 302px;
        }
        #weapons {
            width: 300px;
        }
        table {
            border: 30px solid transparent;
            padding: 0px;
            border-image: url(images/border.png) repeat round;
            border-image-slice: 19;
        }
        th, td {
            border: 1px solid black;
            border-collapse: collapse;
        }
        th, td {
            padding: 10px;
        }
        tr {
            
        }
        
        .img{
            height : 54px;
            width : 50px;
        }
        .btn {
            margin: 0;
            width: 30px;
            height: 30px;
            font-size: 20px;
            text-align: center;
            color: #222;
            padding-top: 5px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            Name</div>
    <p>
        <input id="nameField" type="text" /> &nbsp; &nbsp; &nbsp; <asp:Button ID="enterName" runat="server" Text="Enter name" OnClick="nameConfirm" />
        </p>

        <asp:Image id="raceImage" runat="server"
           CssClass="img" 
           ImageAlign="left"
           ImageUrl=""/>

           <asp:Image id="classImage" runat="server"
           CssClass="img" 
           ImageAlign="left"
           ImageUrl=""/>
    
    
    
    <table style="width:100%">
        <tr>
            <th>
                Choose Race
                <asp:DropDownList id="raceSelect" name="raceSelect" runat="server" 
                AutoPostBack="true" OnSelectedIndexChanged="updateRaceImg">
                    <asp:ListItem value="6">Elf: Eladrin</asp:ListItem>
                    <asp:ListItem value="7">Elf: High Elf</asp:ListItem>
                    <asp:ListItem value="8">Elf: Wood Elf</asp:ListItem>
                    <asp:ListItem value="9">Dragonborn</asp:ListItem>
                    <asp:ListItem value="10">Dwarf: Hill Dwarf</asp:ListItem>
                    <asp:ListItem value="11">Dwarf: Mountain Dwarf</asp:ListItem>
                    <asp:ListItem value="12">Gnome: Forest Gnome</asp:ListItem>
                    <asp:ListItem value="13">Gnome: Deep Gnome</asp:ListItem>
                    <asp:ListItem value="14">Gnome: Rock Gnome</asp:ListItem>
                    <asp:ListItem value="15">Half-Elf</asp:ListItem>
                    <asp:ListItem value="16">Halfling: Lightfoot</asp:ListItem>
                    <asp:ListItem value="17">Halfling: Stout</asp:ListItem>
                    <asp:ListItem value="19">Half-Orc</asp:ListItem>
                    <asp:ListItem value="20">Human</asp:ListItem>
                    <asp:ListItem value="21">Tiefling</asp:ListItem>
                </asp:DropDownList>
                
            </th>
            <th>
                Choose Class
                <asp:DropDownList id="classSelect" name="classSelect" runat="server" 
                AutoPostBack="true" OnSelectedIndexChanged="updateClassImg">
                    <asp:ListItem value="1002">Barbarian</asp:ListItem>
                    <asp:ListItem value="1003">Bard</asp:ListItem>
                    <asp:ListItem value="1004">Cleric</asp:ListItem>
                    <asp:ListItem value="1005">Druid</asp:ListItem> 
                    <asp:ListItem value="1006">Fighter</asp:ListItem>
                    <asp:ListItem value="1007">Monk</asp:ListItem>
                    <asp:ListItem value="1008">Paladin</asp:ListItem>
                    <asp:ListItem value="1009">Ranger</asp:ListItem>
                    <asp:ListItem value="1010">Rogue</asp:ListItem>
                    <asp:ListItem value="1011">Sorcerer</asp:ListItem>
                    <asp:ListItem value="1012">Warlock</asp:ListItem>
                    <asp:ListItem value="1013">Wizard</asp:ListItem>
                </asp:DropDownList>
            </th>
        </tr>
        <tr>
            <th>
                Choose Alignment
                <select id="alignmentSelect" name="alignmentSelect" runat="server">
                    <option value ="LG">Lawful Good</option>
                    <option value ="NG">Neutral Good</option>
                    <option value ="CG">Chaotic Good</option>
                    <option value ="LN">Lawful Neutral</option>
                    <option value ="NN">True Neutral</option>
                    <option value ="CN">Chaotic Neutral</option>
                    <option value ="LE">Lawful Evil</option>
                    <option value ="NE">Neutral Evil</option>
                    <option value ="CE">Chaotic Evil</option>
                </select></th>
            <th>
                Choose Level
                <select id="levelSelect" name="levelSelect" runat="server">
                    <option value="1">1</option>
                    <option value="2">2</option>
                    <option value="3">3</option>
                    <option value="4">4</option>
                    <option value="5">5</option>
                    <option value="6">6</option>
                    <option value="7">7</option>
                    <option value="8">8</option>
                    <option value="9">9</option>
                    <option value="10">10</option>
                    <option value="11">11</option>
                    <option value="12">12</option>
                    <option value="13">13</option>
                    <option value="14">14</option>
                    <option value="15">15</option>
                    <option value="16">16</option>
                    <option value="17">17</option>
                    <option value="18">18</option>
                    <option value="19">19</option>
                    <option value="20">20</option>
                </select></th>
        </tr>
    </table>
    

    <table style="width:100%">
        <tr>
            <tr>
                <th>Abilities</th>
                <th>Brute Score</th>
                <th>Racial Bonus</th>
                <th>Final Score</th>
                <td rowspan="7" style="width:50%">
                    <h3>Class Description:</h3>
                    <asp:Label id="classInfo" text="gibberish3" runat="server"></asp:Label>
                    <br />
                    <h3>Race Description:</h3>
                    <asp:Label id="raceInfo" text="gibberish" runat="server"></asp:Label>
                </td>
            </tr>
            <tr>
                <th>Strength</th>
                <th>
                    <asp:Button text="-" OnClick="updateAbility" id="strDwn" runat="server"></asp:Button>
                    <asp:Label id="Str" text="10" runat="server"></asp:Label>
                    <asp:Button text="+" OnClick="updateAbility" id="strUp" runat="server"></asp:Button>
                </th>
                <th><asp:Label id="rStr" text="0" runat="server"></asp:Label></th>
                <th><asp:Label id="fStr" runat="server"></asp:Label></th>
            </tr>
            <tr>
                <th>Dextarity</th>
                <th>
                    <asp:Button text="-" OnClick="updateAbility" id="dexDwn" runat="server"></asp:Button>
                    <asp:Label id="Dex" text="10" runat="server"></asp:Label>
                    <asp:Button text="+" OnClick="updateAbility" id="dexUp" runat="server"></asp:Button>
                </th>
                <th><asp:Label id="rDex" text="0" runat="server"></asp:Label></th>
                <th><asp:Label id="fDex" runat="server"></asp:Label></th>
            </tr>
            <tr>
                <th>Constitution</th>
                <th>
                    <asp:Button text="-" OnClick="updateAbility" id="conDwn" runat="server"></asp:Button>
                    <asp:Label id="Con" text="10" runat="server"></asp:Label>
                    <asp:Button text="+" OnClick="updateAbility" id="conUp" runat="server"></asp:Button>
                </th>
                <th><asp:Label id="rCon" text="0" runat="server"></asp:Label></th>
                <th><asp:Label id="fCon" runat="server"></asp:Label></th>
            <tr>
                <th>Itelligence</th>
                <th>
                    <asp:Button text="-" OnClick="updateAbility" id="intDwn" runat="server"></asp:Button>
                    <asp:Label id="Int" text="10" runat="server"></asp:Label>
                    <asp:Button text="+" OnClick="updateAbility" id="intUp" runat="server"></asp:Button>
                </th>
                <th><asp:Label id="rInt" text="0" runat="server"></asp:Label></th>
                <th><asp:Label id="fInt" runat="server"></asp:Label></th>
            </tr>
            <tr>
                <th>Wisdom</th>
                <th>
                    <asp:Button text="-" OnClick="updateAbility" id="wisDwn" runat="server"></asp:Button>
                    <asp:Label id="Wis" text="10" runat="server"></asp:Label>
                    <asp:Button text="+" OnClick="updateAbility" id="wisUp" runat="server"></asp:Button>
                </th>
                <th><asp:Label id="rWis" text="0" runat="server"></asp:Label></th>
                <th><asp:Label id="fWis" runat="server"></asp:Label></th>
            </tr>
            <tr>
                <th>Charisma</th>
                <th>
                    <asp:Button text="-" OnClick="updateAbility" id="chaDwn" runat="server"></asp:Button>
                    <asp:Label id="Cha" text="10" runat="server"></asp:Label>
                    <asp:Button text="+" OnClick="updateAbility" id="chaUp" runat="server"></asp:Button>
                </th>
                <th><asp:Label id="rCha" text="0" runat="server"></asp:Label></th>
                <th><asp:Label id="fCha" runat="server"></asp:Label></th>
            </tr>
        </tr>
    </table>
    <table style="width:100%">
        <tr>
            <th style="text-align:left">
                <asp:CheckBox ID="abi_athletics" runat="server" GroupName="ability" Text="Athletics" /> <br />
                <asp:CheckBox ID="abi_acrobatics" runat="server" GroupName="ability" Text="Acrobatics" /> <br />
                <asp:CheckBox ID="abi_slightofhand" runat="server" GroupName="ability" Text="Sleight of Hand" /> <br />
                <asp:CheckBox ID="abi_stelth" runat="server" GroupName="ability" Text="Stealth" /> <br />
                <asp:CheckBox ID="abi_arcana" runat="server" GroupName="ability" Text="Arcana" /> <br />
                <asp:CheckBox ID="abi_history" runat="server" GroupName="ability" Text="History" /> <br />
            </th>
            <th style="text-align:left">
                <asp:CheckBox ID="abi_investigation" runat="server" GroupName="ability" Text="Investigation" /> <br />
                <asp:CheckBox ID="abi_nature" runat="server" GroupName="ability" Text="Nature" /> <br />
                <asp:CheckBox ID="abi_religion" runat="server" GroupName="ability" Text="Religion" /> <br />
                <asp:CheckBox ID="abi_animalhandling" runat="server" GroupName="ability" Text="Animal Handling" /> <br />
                <asp:CheckBox ID="abi_insight" runat="server" GroupName="ability" Text="Insight" /> <br />
                <asp:CheckBox ID="abi_medicine" runat="server" GroupName="ability" Text="Medicine" /> <br />
            </th>
            <th style="text-align:left">
                <asp:CheckBox ID="abi_percption" runat="server" GroupName="ability" Text="Perception" /> <br />
                <asp:CheckBox ID="abi_survival" runat="server" GroupName="ability" Text="Survival" /> <br />
                <asp:CheckBox ID="abi_deception" runat="server" GroupName="ability" Text="Deception" /> <br />
                <asp:CheckBox ID="abi_intimidation" runat="server" GroupName="ability" Text="Intimidation" /> <br />
                <asp:CheckBox ID="abi_performance" runat="server" GroupName="ability" Text="Performance" /> <br />
                <asp:CheckBox ID="abi_persuasion" runat="server" GroupName="ability" Text="Persuasion" /> <br />
            </th>
        </tr>
    </table>
</form>   
    <p>
        Enter Abilities</p>
    <p>
        &nbsp;</p>
    <p>
        Choose subclass
    </p>
    <p>
        <select id="subclass" name="D5" runat="server">
            <option></option>
        </select></p>
    <p>
        Choose skills</p>
    <p>
        &nbsp;</p>
    <p>
        Choose feats</p>
    <p>
        <select id="feats" name="D6" runat="server">
            <option></option>
        </select></p>
    <p>
        Choose armor</p>
    <p>
        <select id="armor" name="D7" runat="server">
            <option></option>
        </select></p>
    <p>
        Choose weapons</p>
    <select id="weapons" name="D8" runat="server">
        <option></option>
    </select>
</body>
</html>
