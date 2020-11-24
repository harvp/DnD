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

        protected void updateClassImg(object sender, EventArgs e)
    {
        if (classSelect == 1002)
            Image1. = "You have opeted for online tutorial.";
        else
            lblMessage.ImageURL= "http://papermoondance.com/wp-content/uploads/2019/05/It-Must-Be-a-Duck-862x862.jpg";
    }

        
        
        

    }
}