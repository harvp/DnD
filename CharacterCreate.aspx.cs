using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.Diagnostics;
using System.Web.Services.Description;
using System.Configuration;
using System.Text;
using System.Xml.Linq;

namespace DnD
{
    public partial class CharacterCreate : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        public void nameConfirm(object sender, EventArgs e)
        {

        }

        public void updateClassImg(object sender, EventArgs e)
        {    
            string i = classSelect.SelectedValue;
            switch (i)
            {
                case "1002":
                    classImage.ImageUrl = "images/class_barbarian.png";
                    break;
                case "1003":
                    classImage.ImageUrl = "images/class_bard.png";
                    break;
                case "1004":
                    classImage.ImageUrl = "images/class_cleric.png";
                    break;
                case "1005":
                    classImage.ImageUrl = "images/class_druid.png";
                    break;
                case "1006":
                    classImage.ImageUrl = "images/class_fighter.png";
                    break;
                case "1007":
                    classImage.ImageUrl = "images/class_monk.png";
                    break;
                case "1008":
                    classImage.ImageUrl = "images/class_paladin.png";
                    break;
                case "1009":
                    classImage.ImageUrl = "images/class_ranger.png";
                    break;
                case "1010":
                    classImage.ImageUrl = "images/class_rogue.png";
                    break;
                case "1011":
                    classImage.ImageUrl = "images/class_sorcerer.png";
                    break;
                case "1012":
                    classImage.ImageUrl = "images/class_warlock.png";
                    break;
                case "1013":
                    classImage.ImageUrl = "images/class_wizard.png";
                    break;
                default :
                    classImage.ImageUrl = "https://images2.minutemediacdn.com/image/upload/c_crop,h_843,w_1500,x_0,y_10/f_auto,q_auto,w_1100/v1555172614/shape/mentalfloss/iStock-177369626_1.jpg";
                    break;
            }
        }
        public void updateRaceImg(object sender, EventArgs e)
        {    
            string i = raceSelect.SelectedValue;
            switch (i)
            {
                case "6":
                    raceImage.ImageUrl = "images/race_highelf.png";
                    break;
                case "7":
                    raceImage.ImageUrl = "images/race_highelf.png";
                    break;
                case "8":
                    raceImage.ImageUrl = "images/race_highelf.png";
                    break;
                case "9":
                    raceImage.ImageUrl = "images/race_dragonborn.png";
                    break;
                case "10":
                    raceImage.ImageUrl = "images/race_gnome.png";
                    break;
                case "11":
                    raceImage.ImageUrl = "images/race_gnome.png";
                    break;
                case "12":
                    raceImage.ImageUrl = "images/race_gnome.png";
                    break;
                case "13":
                    raceImage.ImageUrl = "images/race_gnome.png";
                    break;
                case "14":
                    raceImage.ImageUrl = "images/race_gnome.png";
                    break;
                case "15":
                    raceImage.ImageUrl = "images/race_halfelf.png";
                    break;
                case "16":
                    raceImage.ImageUrl = "images/race_halfling.png";
                    break;
                case "17":
                    raceImage.ImageUrl = "images/race_halfling.png";
                    break;
                case "18":
                    raceImage.ImageUrl = "images/race_halfling.png";
                    break;
                case "19":
                    raceImage.ImageUrl = "images/race_halforc.png";
                    break;
                case "20":
                    raceImage.ImageUrl = "images/race_human.png";
                    break;
                case "21":
                    raceImage.ImageUrl = "images/race_tiefling.png";
                    break;
                default :
                    raceImage.ImageUrl = "https://images2.minutemediacdn.com/image/upload/c_crop,h_843,w_1500,x_0,y_10/f_auto,q_auto,w_1100/v1555172614/shape/mentalfloss/iStock-177369626_1.jpg";
                    break;
            }
        }
        public void updateRaceAbilities(string race)
        {    
            switch (race)
            {
                case "human":
                    rStr.Text = "1";
                    rDex.Text = "1";
                    rCon.Text = "1";
                    rInt.Text = "1";
                    rWis.Text = "1";
                    rCha.Text = "1";
                    break;
                default :
                    break;
            }
        }   
        public void updateAbility(object sender, EventArgs e)
        {
            Button button = (Button)sender;
            string buttonId = button.ID;
            
            switch (buttonId)
            {
                case "strDwn":
                    Str.Text = (int.Parse(Str.Text) - 1).ToString();
                    break;
                case "strUp":
                    Str.Text = (int.Parse(Str.Text) + 1).ToString();
                    break;
                case "dexDwn":
                    Dex.Text = (int.Parse(Dex.Text) - 1).ToString();
                    break;
                case "dexUp":
                    Dex.Text = (int.Parse(Dex.Text) + 1).ToString();
                    break;
                case "conDwn":
                    Con.Text = (int.Parse(Con.Text) - 1).ToString();
                    break;
                case "conUp":
                    Con.Text = (int.Parse(Con.Text) + 1).ToString();
                    break;
                case "intDwn":
                    Int.Text = (int.Parse(Int.Text) - 1).ToString();
                    break;
                case "intUp":
                    Int.Text = (int.Parse(Int.Text) + 1).ToString();
                    break;
                case "wisDwn":
                    Wis.Text = (int.Parse(Wis.Text) - 1).ToString();
                    break;
                case "wisUp":
                    Wis.Text = (int.Parse(Wis.Text) + 1).ToString();
                    break;
                case "chaDwn":
                    Cha.Text = (int.Parse(Cha.Text) - 1).ToString();
                    break;
                case "chaUp":
                    Cha.Text = (int.Parse(Cha.Text) + 1).ToString();
                    break;
                default :
                    Str.Text = "10";
                    Dex.Text = "10";
                    Con.Text = "10";
                    Int.Text = "10";
                    Wis.Text = "10";
                    Cha.Text = "10";
                    break;
            }
            fStr.Text = (int.Parse(Str.Text) + int.Parse(rStr.Text)).ToString();
            fDex.Text = (int.Parse(Dex.Text) + int.Parse(rDex.Text)).ToString();
            fCon.Text = (int.Parse(Con.Text) + int.Parse(rCon.Text)).ToString();
            fInt.Text = (int.Parse(Int.Text) + int.Parse(rInt.Text)).ToString();
            fWis.Text = (int.Parse(Wis.Text) + int.Parse(rWis.Text)).ToString();
            fCha.Text = (int.Parse(Cha.Text) + int.Parse(rCha.Text)).ToString();
        }    
    }
}