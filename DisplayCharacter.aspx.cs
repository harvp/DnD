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
using System.Data.SqlClient;
using System.Data;

namespace DnD
{
    public partial class DisplayCharacter : System.Web.UI.Page
    {
        SqlConnectionStringBuilder builder = new SqlConnectionStringBuilder
        {
            DataSource = "hrpsvr.database.windows.net",
            UserID = "hrpzip",
            Password = "DBMProject1!",
            InitialCatalog = "DnD"
        };
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                SqlConnectionStringBuilder builder = new SqlConnectionStringBuilder
                {
                    DataSource = "hrpsvr.database.windows.net",
                    UserID = "hrpzip",
                    Password = "DBMProject1!",
                    InitialCatalog = "DnD"
                };

                using (SqlConnection connection = new SqlConnection(builder.ConnectionString))
                {
                    string queryBuild = "SELECT * FROM Character WHERE userID = 1;";
                    SqlDataAdapter command = new SqlDataAdapter(queryBuild, connection);
                    connection.Open();

                    DataSet ds = new DataSet();
                    command.Fill(ds, "DeckList");

                    Select1.DataSource = ds;
                    Select1.DataTextField = "name";
                    Select1.DataValueField = "charID";
                    Select1.DataBind();
                }
            }
        }
        public void SubmitDisplay(object sender, EventArgs e)
        {
            
        }
    }
}