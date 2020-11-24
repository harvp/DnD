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
                    image1.ImageUrl = "http://papermoondance.com/wp-content/uploads/2019/05/It-Must-Be-a-Duck-862x862.jpg";
                    break;
                case "1003":
                    image1.ImageUrl = "https://ichef.bbci.co.uk/news/800/cpsprodpb/C271/production/_98677794_gettyimages-486869012.jpg";
                    break;
                default :
                    image1.ImageUrl = "https://images2.minutemediacdn.com/image/upload/c_crop,h_843,w_1500,x_0,y_10/f_auto,q_auto,w_1100/v1555172614/shape/mentalfloss/iStock-177369626_1.jpg";
                    break;
            }
      
        }       

    }
}