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
        th {
            border: 1px solid black;
            border-collapse: collapse;
        }
        th {
            padding: 10px;
        }
        td {
            padding: 0px;
            border: 1px hidden;
            border-collapse: collapse;
        }
        
        .img{
            height : 80px;
            width : 80px;
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

        <div class="navbar navbar-inverse navbar-fixed-top" style="background-color: DarkRed">
            <div class="container">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a class="navbar-brand" runat="server" href="~/">Dungeons and Dragons Character Creator</a>
                </div>
                
                <div class="navbar-collapse collapse">
                    <ul class="nav navbar-nav">
                        <li><a runat="server" href="~/">Home</a></li>
                        <li><a runat="server" href="~/About">About</a></li>
                    </ul>
                </div>
            </div>
        </div>
        <asp:Label ID="Label1" runat="server" Text="login"></asp:Label>
            <asp:TextBox ID="TextBoxUsername" placeholder="username" runat="server"></asp:TextBox>
            <asp:TextBox ID="TextBoxPassword" placeholder="password" TextMode="Password" runat="server"></asp:TextBox>
            <asp:PlaceHolder ID="Signin"
                runat="server"/>
            <button><a runat="server" href="~/Register">Register</a></button>
            <td><asp:Label ID="Label4" runat="server"></asp:Label></td>
            <td><asp:Label ID="Label3" runat="server"></asp:Label></td>
            <hr />

    <table  style="width:100%">
        <tr>
            <th style="width:40%">
                Name
                <asp:TextBox id="nameField" runat="server"/> <br/>
                <asp:Button ID="enterName" runat="server" Text="Add Character" OnClick="nameConfirm" />
            </th>
            <th style="width:30%">
                <asp:Image id="raceImage" runat="server"
                CssClass="img" 
                ImageAlign="Middle"
                ImageUrl=""/>
    
                <asp:Image id="classImage" runat="server"
                CssClass="img" 
                ImageAlign="Middle"
                ImageUrl=""/>
            </th>
            <th style="width:30%">
                Hit Points:
                <asp:Label id="hitPoints" text="20" runat="server" />
            </th>
        </tr>
    </table>    
        

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
                <asp:DropDownList id="alignSelect" name="alignSelect" runat="server" 
                AutoPostBack="true">
                    <asp:ListItem value="LG">Lawful Good</asp:ListItem>
                    <asp:ListItem value="NG">Neutral Good</asp:ListItem>
                    <asp:ListItem value="CG">Chaotic Good</asp:ListItem>
                    <asp:ListItem value="LN">Lawful Neutral</asp:ListItem>
                    <asp:ListItem value="NN">True Neutral</asp:ListItem>
                    <asp:ListItem value="CN">Chaotic Neutral</asp:ListItem>
                    <asp:ListItem value="LE">Lawful Evil</asp:ListItem>
                    <asp:ListItem value="NE">Neutral Evil</asp:ListItem>
                    <asp:ListItem value="CE">Chaotic Evil</asp:ListItem>
                </asp:DropDownList>
            </th>
            <th>
                Choose Level
                <asp:DropDownList id="lvllSelect" name="lvllSelect" runat="server" 
                AutoPostBack="true" OnSelectedIndexChanged="updateHitPoints">
                    <asp:ListItem value="1">1</asp:ListItem>
                    <asp:ListItem value="2">2</asp:ListItem>
                    <asp:ListItem value="3">3</asp:ListItem>
                    <asp:ListItem value="4">4</asp:ListItem>
                    <asp:ListItem value="5">5</asp:ListItem>
                    <asp:ListItem value="6">6</asp:ListItem>
                    <asp:ListItem value="7">7</asp:ListItem>
                    <asp:ListItem value="8">8</asp:ListItem>
                    <asp:ListItem value="9">9</asp:ListItem>
                    <asp:ListItem value="10">10</asp:ListItem>
                    <asp:ListItem value="11">11</asp:ListItem>
                    <asp:ListItem value="12">12</asp:ListItem>
                    <asp:ListItem value="13">13</asp:ListItem>
                    <asp:ListItem value="14">14</asp:ListItem>
                    <asp:ListItem value="15">15</asp:ListItem>
                    <asp:ListItem value="16">16</asp:ListItem>
                    <asp:ListItem value="17">17</asp:ListItem>
                    <asp:ListItem value="18">18</asp:ListItem>
                    <asp:ListItem value="19">19</asp:ListItem>
                    <asp:ListItem value="20">20</asp:ListItem>
                </asp:DropDownList>
            </th>
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
                    <asp:Label id="classInfo" text="" runat="server"></asp:Label>
                    <br />
                    <h3>Race Description:</h3>
                    <asp:Label id="raceInfo" text="" runat="server"></asp:Label>
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
                <th><asp:Label id="fStr" text="10" runat="server"></asp:Label></th>
            </tr>
            <tr>
                <th>Dextarity</th>
                <th>
                    <asp:Button text="-" OnClick="updateAbility" id="dexDwn" runat="server"></asp:Button>
                    <asp:Label id="Dex" text="10" runat="server"></asp:Label>
                    <asp:Button text="+" OnClick="updateAbility" id="dexUp" runat="server"></asp:Button>
                </th>
                <th><asp:Label id="rDex" text="0" runat="server"></asp:Label></th>
                <th><asp:Label id="fDex" text="10" runat="server"></asp:Label></th>
            </tr>
            <tr>
                <th>Constitution</th>
                <th>
                    <asp:Button text="-" OnClick="updateAbility" id="conDwn" runat="server"></asp:Button>
                    <asp:Label id="Con" text="10" runat="server"></asp:Label>
                    <asp:Button text="+" OnClick="updateAbility" id="conUp" runat="server"></asp:Button>
                </th>
                <th><asp:Label id="rCon" text="0" runat="server"></asp:Label></th>
                <th><asp:Label id="fCon" text="10" runat="server"></asp:Label></th>
            <tr>
                <th>Itelligence</th>
                <th>
                    <asp:Button text="-" OnClick="updateAbility" id="intDwn" runat="server"></asp:Button>
                    <asp:Label id="Int" text="10" runat="server"></asp:Label>
                    <asp:Button text="+" OnClick="updateAbility" id="intUp" runat="server"></asp:Button>
                </th>
                <th><asp:Label id="rInt" text="0" runat="server"></asp:Label></th>
                <th><asp:Label id="fInt" text="10" runat="server"></asp:Label></th>
            </tr>
            <tr>
                <th>Wisdom</th>
                <th>
                    <asp:Button text="-" OnClick="updateAbility" id="wisDwn" runat="server"></asp:Button>
                    <asp:Label id="Wis" text="10" runat="server"></asp:Label>
                    <asp:Button text="+" OnClick="updateAbility" id="wisUp" runat="server"></asp:Button>
                </th>
                <th><asp:Label id="rWis" text="0" runat="server"></asp:Label></th>
                <th><asp:Label id="fWis" text="10" runat="server"></asp:Label></th>
            </tr>
            <tr>
                <th>Charisma</th>
                <th>
                    <asp:Button text="-" OnClick="updateAbility" id="chaDwn" runat="server"></asp:Button>
                    <asp:Label id="Cha" text="10" runat="server"></asp:Label>
                    <asp:Button text="+" OnClick="updateAbility" id="chaUp" runat="server"></asp:Button>
                </th>
                <th><asp:Label id="rCha" text="0" runat="server"></asp:Label></th>
                <th><asp:Label id="fCha" text="10" runat="server"></asp:Label></th>
            </tr>
        </tr>
    </table>
    <table style="width:100%">
        <tr>
            <td>
                Skills:
            </td>
        </tr>
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
    <table style="width:100%">
        <tr>
            <td>
                Feats:
            </td>
        </tr>
        <tr>
            <th style="text-align:left">
                <asp:CheckBox ID="feat_actor" runat="server" GroupName="feat" Text="Actor" /> <br />
                <asp:CheckBox ID="feat_alert" runat="server" GroupName="feat" Text="Alert" /> <br />
                <asp:CheckBox ID="feat_athlete" runat="server" GroupName="feat" Text="Athlete" /> <br />
                <asp:CheckBox ID="feat_bountifulluck" runat="server" GroupName="feat" Text="Bountiful Luck" /> <br />
                <asp:CheckBox ID="feat_charger" runat="server" GroupName="feat" Text="Charger" /> <br />
                <asp:CheckBox ID="feat_crossbowexpert" runat="server" GroupName="feat" Text="Crossbow Exper" /> <br />

                <asp:CheckBox ID="feat_defensiveduelist" runat="server" GroupName="feat" Text="Defensive Duelist" /> <br />
                <asp:CheckBox ID="feat_dragonfear" runat="server" GroupName="feat" Text="Dragon Fear" /> <br />
                <asp:CheckBox ID="feat_dragonhide" runat="server" GroupName="feat" Text="Dragon Hide" /> <br />
                <asp:CheckBox ID="feat_drowhighagic" runat="server" GroupName="feat" Text="Drow High Magic" /> <br />
                <asp:CheckBox ID="feat_dualwielder" runat="server" GroupName="feat" Text="Dual Wielder" /> <br />
                <asp:CheckBox ID="feat_dungeoundelver" runat="server" GroupName="feat" Text="Dungeon Delver" /> <br />

                <asp:CheckBox ID="feat_durable" runat="server" GroupName="feat" Text="Durable" /> <br />
                <asp:CheckBox ID="feat_dwarffortitude" runat="server" GroupName="feat" Text="DwarF Fortitude" /> <br />
                <asp:CheckBox ID="feat_elementaladept" runat="server" GroupName="feat" Text="Elemental Adept" /> <br />
                <asp:CheckBox ID="feat_elvenaccuracy" runat="server" GroupName="feat" Text="Elven Accuracy" /> <br />
                <asp:CheckBox ID="feat_fadeaway" runat="server" GroupName="feat" Text="Fade Away" /> <br />
                <asp:CheckBox ID="feat_feytransportation" runat="server" GroupName="feat" Text="Fey Transportation" /> <br />
            </th>
            <th style="text-align:left">
                <asp:CheckBox ID="feat_flamesofphlegethos" runat="server" GroupName="feat" Text="Flames of Phlegethos" /> <br />
                <asp:CheckBox ID="feat_grappler" runat="server" GroupName="feat" Text="Grappler" /> <br />
                <asp:CheckBox ID="feat_greatweaponmaster" runat="server" GroupName="feat" Text="Great Weapon Master" /> <br />
                <asp:CheckBox ID="feat_healer" runat="server" GroupName="feat" Text="Healer" /> <br />
                <asp:CheckBox ID="feat_heavilyarmored" runat="server" GroupName="feat" Text="Heavily Armored" /> <br />
                <asp:CheckBox ID="feat_heavyarmormaster" runat="server" GroupName="feat" Text="Heavy Armor Master" /> <br />

                <asp:CheckBox ID="feat_infernalconstitution" runat="server" GroupName="feat" Text="Infernal Constitution" /> <br />
                <asp:CheckBox ID="feat_inspiringleader" runat="server" GroupName="feat" Text="Inspiring Leader" /> <br />
                <asp:CheckBox ID="feat_keenmind" runat="server" GroupName="feat" Text="Keen Mind" /> <br />
                <asp:CheckBox ID="feat_lightlyarmored" runat="server" GroupName="feat" Text="Lightly Armored" /> <br />
                <asp:CheckBox ID="feat_linguist" runat="server" GroupName="feat" Text="Linguist" /> <br />
                <asp:CheckBox ID="feat_lucky" runat="server" GroupName="feat" Text="Lucky" /> <br />

                <asp:CheckBox ID="feat_mageslayer" runat="server" GroupName="feat" Text="Mage Slayer" /> <br />
                <asp:CheckBox ID="feat_magicinitiate" runat="server" GroupName="feat" Text="Magic Initiate" /> <br />
                <asp:CheckBox ID="feat_martialadept" runat="server" GroupName="feat" Text="Martial Adept" /> <br />
                <asp:CheckBox ID="feat_mediumarmormaster" runat="server" GroupName="feat" Text="Medium Armor Master" /> <br />
                <asp:CheckBox ID="feat_mobile" runat="server" GroupName="feat" Text="Mobile" /> <br />
                <asp:CheckBox ID="feat_moderatelyarmored" runat="server" GroupName="feat" Text="Moderately Armored" /> <br />
            </th>
            <th style="text-align:left">
                <asp:CheckBox ID="feat_mountedcombatant" runat="server" GroupName="feat" Text="Mounted Combatant" /> <br />
                <asp:CheckBox ID="feat_observant" runat="server" GroupName="feat" Text="Observant" /> <br />
                <asp:CheckBox ID="feat_polearmmaster" runat="server" GroupName="feat" Text="Polearm Master" /> <br />
                <asp:CheckBox ID="feat_resilient" runat="server" GroupName="feat" Text="Resilient" /> <br />
                <asp:CheckBox ID="feat_ritualcaster" runat="server" GroupName="feat" Text="Ritual Caster" /> <br />
                <asp:CheckBox ID="feat_savageattacker" runat="server" GroupName="feat" Text="Savage Attacker" /> <br />

                <asp:CheckBox ID="feat_sentinel" runat="server" GroupName="feat" Text="Sentinel" /> <br />
                <asp:CheckBox ID="feat_sharpshooter" runat="server" GroupName="feat" Text="Sharpshooter" /> <br />
                <asp:CheckBox ID="feat_shieldmaster" runat="server" GroupName="feat" Text="Shield Master" /> <br />
                <asp:CheckBox ID="feat_skilled" runat="server" GroupName="feat" Text="Skilled" /> <br />
                <asp:CheckBox ID="feat_skulker" runat="server" GroupName="feat" Text="Skulker" /> <br />
                <asp:CheckBox ID="feat_spellsniper" runat="server" GroupName="feat" Text="Spell Sniper" /> <br />
                
                <asp:CheckBox ID="feat_tavernbrawler" runat="server" GroupName="feat" Text="Tavern Brawler" /> <br />
                <asp:CheckBox ID="feat_tough" runat="server" GroupName="feat" Text="Tough" /> <br />
                <asp:CheckBox ID="feat_warcaster" runat="server" GroupName="feat" Text="War Caster" /> <br />
                <asp:CheckBox ID="feat_weaponmaster" runat="server" GroupName="feat" Text="Waepon Master" /> <br />
            </th>
        </tr>
    </table>
    <table>
        <tr>
            <th>
                <asp:DropDownList ID="DropDownList1" runat="server"> </asp:DropDownList>  
            </th>
        </tr>
    </table>
</form>   

    <p>
        Choose subclass
    </p>
    <p>
        <select id="subclass" name="D5" runat="server">
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
