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


                int userIDNumber = 1;

                using (SqlConnection connection = new SqlConnection(builder.ConnectionString))
                {
                    string User_name = Request.Cookies["username"].Value;
                    connection.Open();
                    string myIdQuery = "SELECT userID FROM UserInfo WHERE username ="
                        + " '" + User_name + "' ";
                    SqlCommand command1 = new SqlCommand(myIdQuery, connection);
                    int i = 0;
                    object user_id = command1.ExecuteScalar();
                    if (user_id != null)
                        i = (int)user_id;
                    userIDNumber = i;
                    
                }

                using (SqlConnection connection = new SqlConnection(builder.ConnectionString))
                {
                    string queryBuild = "SELECT * FROM Character WHERE userID = " + userIDNumber + ";";
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
        public void submitDisplay(object sender, EventArgs e)
        {
            int userIDNumber = 1;
            

            using (SqlConnection connection = new SqlConnection(builder.ConnectionString))
            {
                string User_name = Request.Cookies["username"].Value;
                connection.Open();
                string myIdQuery = "SELECT userID FROM UserInfo WHERE username ="
                    + " '" + User_name + "' ";
                SqlCommand command1 = new SqlCommand(myIdQuery, connection);
                int i = 0;
                object user_id = command1.ExecuteScalar();
                if (user_id != null)
                    i = (int)user_id;
                userIDNumber = i;
                playerName.InnerText = User_name;
            }

            string myCharID = Select1.Value.ToString();
            //Display Abilities
            using (SqlConnection connection = new SqlConnection(builder.ConnectionString))
            {
                string queryBuild = "SELECT name FROM Character WHERE charID = " + myCharID + ";";
                SqlCommand command = new SqlCommand(queryBuild, connection);
                command.CommandType = System.Data.CommandType.Text;
                connection.Open();
                string temp = "";

                SqlDataReader reader = command.ExecuteReader();
                while (reader.Read())
                {
                    temp += reader["name"].ToString();
                }
                characterName.InnerText = temp;
                
            }
            //hit points
            using (SqlConnection connection = new SqlConnection(builder.ConnectionString))
            {
                string queryBuild = "SELECT hitPoints FROM Character WHERE charID = " + myCharID + ";";
                SqlCommand command = new SqlCommand(queryBuild, connection);
                command.CommandType = System.Data.CommandType.Text;
                connection.Open();
                string temp = "";

                SqlDataReader reader = command.ExecuteReader();
                while (reader.Read())
                {
                    temp += reader["hitPoints"].ToString();
                }
                p1.InnerText = temp;

            }

            //alignment
            using (SqlConnection connection = new SqlConnection(builder.ConnectionString))
            {
                string queryBuild = "SELECT alignment FROM Character WHERE charID = " + myCharID + ";";
                SqlCommand command = new SqlCommand(queryBuild, connection);
                command.CommandType = System.Data.CommandType.Text;
                connection.Open();
                string temp = "";

                SqlDataReader reader = command.ExecuteReader();
                while (reader.Read())
                {
                    temp += reader["alignment"].ToString();
                }
                align.InnerText = temp;

            }

            //experience
            using (SqlConnection connection = new SqlConnection(builder.ConnectionString))
            {
                string queryBuild = "SELECT experience FROM Character WHERE charID = " + myCharID + ";";
                SqlCommand command = new SqlCommand(queryBuild, connection);
                command.CommandType = System.Data.CommandType.Text;
                connection.Open();
                string temp = "";

                SqlDataReader reader = command.ExecuteReader();
                while (reader.Read())
                {
                    temp += reader["experience"].ToString();
                }
                exp.InnerText = temp;

            }

            //Class Abilities
            using (SqlConnection connection = new SqlConnection(builder.ConnectionString))
                {
                    string queryBuild = "select classFeatureName, classFeatureDescription from ClassFeatures where classFeatureID in (select classFeatureID from ClassFeaturesKnown where charID =  " + myCharID + ");";
                    SqlCommand command = new SqlCommand(queryBuild, connection);
                    command.CommandType = System.Data.CommandType.Text;
                    connection.Open();
                    string temp = "";

                    SqlDataReader reader = command.ExecuteReader();
                    while (reader.Read())
                    {
                        temp += reader["classFeatureName"].ToString();
                        temp += "  ";
                        temp += reader["classFeatureDescription"].ToString();
                        temp += "<br />";
                    }
                    p8.InnerHtml = temp;
                }

            //RaceName
            using (SqlConnection connection = new SqlConnection(builder.ConnectionString))
            {
                string queryBuild = "select raceName from Races where raceID in (select raceID from Character where charID =  " + myCharID + ");";
                SqlCommand command = new SqlCommand(queryBuild, connection);
                command.CommandType = System.Data.CommandType.Text;
                connection.Open();
                string temp = "";

                SqlDataReader reader = command.ExecuteReader();
                while (reader.Read())
                {
                    temp += reader["raceName"].ToString();
                }
                p27.InnerText = temp;
            }

            //feats
            using (SqlConnection connection = new SqlConnection(builder.ConnectionString))
            {
                string queryBuild = "select featName, featsDescription from Feats where featID in (select featID from FeatsKnown where charID =  " + myCharID + ");";
                SqlCommand command = new SqlCommand(queryBuild, connection);
                command.CommandType = System.Data.CommandType.Text;
                connection.Open();
                string temp = "";

                SqlDataReader reader = command.ExecuteReader();
                while (reader.Read())
                {
                    temp += reader["featName"].ToString();
                    temp += "  ";
                    temp += reader["featsDescription"].ToString();
                    temp += "<br />";
                }
                feats.InnerHtml = temp;
            }



            //Class
            using (SqlConnection connection = new SqlConnection(builder.ConnectionString))
            {
                string queryBuild = "select className from Class where classID in (select classID from Character where charID =  " + myCharID + ");";
                SqlCommand command = new SqlCommand(queryBuild, connection);
                command.CommandType = System.Data.CommandType.Text;
                connection.Open();
                string temp = "";

                SqlDataReader reader = command.ExecuteReader();
                while (reader.Read())
                {
                    temp += reader["className"].ToString();
                }
                p28.InnerText = temp;
            }

            //Racial Abilities
            using (SqlConnection connection = new SqlConnection(builder.ConnectionString))
            {
                string queryBuild = "select abilityName, abilityDescription from racialAbilities where abilityName in (select abilityName from racialAbilitiesKnown where charID =  " + myCharID + ");";
                SqlCommand command = new SqlCommand(queryBuild, connection);
                command.CommandType = System.Data.CommandType.Text;
                connection.Open();
                string temp = "";

                SqlDataReader reader = command.ExecuteReader();
                while (reader.Read())
                {
                    temp += reader["abilityName"].ToString();
                    temp += "  ";
                    temp += reader["abilityDescription"].ToString();
                    temp += "<br />";
                }
                p29.InnerHtml = temp;
            }

            //Skills

            using (SqlConnection connection = new SqlConnection(builder.ConnectionString))
            {
                string queryBuild = "SELECT proficient FROM SkillProficiency WHERE charID = " + myCharID + "AND skillID = 1003;";
                SqlCommand command = new SqlCommand(queryBuild, connection);
                command.CommandType = System.Data.CommandType.Text;
                connection.Open();
                string temp = "";

                SqlDataReader reader = command.ExecuteReader();
                while (reader.Read())
                {
                    temp += reader["proficient"].ToString();
                }
                int values = 5;
                int.TryParse(temp, out values);
                if (values == 0)
                {
                    p9.InnerText = "Not Proficient";
                }
                else
                {
                    p9.InnerText = "Proficient";
                }

            }

            using (SqlConnection connection = new SqlConnection(builder.ConnectionString))
            {
                string queryBuild = "SELECT proficient FROM SkillProficiency WHERE charID = " + myCharID + "AND skillID = 1004;";
                SqlCommand command = new SqlCommand(queryBuild, connection);
                command.CommandType = System.Data.CommandType.Text;
                connection.Open();
                string temp = "";

                SqlDataReader reader = command.ExecuteReader();
                while (reader.Read())
                {
                    temp += reader["proficient"].ToString();
                }
                int values = 5;
                int.TryParse(temp, out values);
                if (values == 0)
                {
                    p10.InnerText = "Not Proficient";
                }
                else
                {
                    p10.InnerText = "Proficient";
                }

            }
            using (SqlConnection connection = new SqlConnection(builder.ConnectionString))
            {
                string queryBuild = "SELECT proficient FROM SkillProficiency WHERE charID = " + myCharID + "AND skillID = 1005;";
                SqlCommand command = new SqlCommand(queryBuild, connection);
                command.CommandType = System.Data.CommandType.Text;
                connection.Open();
                string temp = "";

                SqlDataReader reader = command.ExecuteReader();
                while (reader.Read())
                {
                    temp += reader["proficient"].ToString();
                }
                int values = 5;
                int.TryParse(temp, out values);
                if (values == 0)
                {
                    p11.InnerText = "Not Proficient";
                }
                else
                {
                    p11.InnerText = "Proficient";
                }

            }
            using (SqlConnection connection = new SqlConnection(builder.ConnectionString))
            {
                string queryBuild = "SELECT proficient FROM SkillProficiency WHERE charID = " + myCharID + "AND skillID = 1006;";
                SqlCommand command = new SqlCommand(queryBuild, connection);
                command.CommandType = System.Data.CommandType.Text;
                connection.Open();
                string temp = "";

                SqlDataReader reader = command.ExecuteReader();
                while (reader.Read())
                {
                    temp += reader["proficient"].ToString();
                }
                int values = 5;
                int.TryParse(temp, out values);
                if (values == 0)
                {
                    p12.InnerText = "Not Proficient";
                }
                else
                {
                    p12.InnerText = "Proficient";
                }

            }
            using (SqlConnection connection = new SqlConnection(builder.ConnectionString))
            {
                string queryBuild = "SELECT proficient FROM SkillProficiency WHERE charID = " + myCharID + "AND skillID = 1007;";
                SqlCommand command = new SqlCommand(queryBuild, connection);
                command.CommandType = System.Data.CommandType.Text;
                connection.Open();
                string temp = "";

                SqlDataReader reader = command.ExecuteReader();
                while (reader.Read())
                {
                    temp += reader["proficient"].ToString();
                }
                int values = 5;
                int.TryParse(temp, out values);
                if (values == 0)
                {
                    p13.InnerText = "Not Proficient";
                }
                else
                {
                    p13.InnerText = "Proficient";
                }

            }
            using (SqlConnection connection = new SqlConnection(builder.ConnectionString))
            {
                string queryBuild = "SELECT proficient FROM SkillProficiency WHERE charID = " + myCharID + "AND skillID = 1008;";
                SqlCommand command = new SqlCommand(queryBuild, connection);
                command.CommandType = System.Data.CommandType.Text;
                connection.Open();
                string temp = "";

                SqlDataReader reader = command.ExecuteReader();
                while (reader.Read())
                {
                    temp += reader["proficient"].ToString();
                }
                int values = 5;
                int.TryParse(temp, out values);
                if (values == 0)
                {
                    p14.InnerText = "Not Proficient";
                }
                else
                {
                    p14.InnerText = "Proficient";
                }

            }
            using (SqlConnection connection = new SqlConnection(builder.ConnectionString))
            {
                string queryBuild = "SELECT proficient FROM SkillProficiency WHERE charID = " + myCharID + "AND skillID = 1009;";
                SqlCommand command = new SqlCommand(queryBuild, connection);
                command.CommandType = System.Data.CommandType.Text;
                connection.Open();
                string temp = "";

                SqlDataReader reader = command.ExecuteReader();
                while (reader.Read())
                {
                    temp += reader["proficient"].ToString();
                }
                int values = 5;
                int.TryParse(temp, out values);
                if (values == 0)
                {
                    p15.InnerText = "Not Proficient";
                }
                else
                {
                    p15.InnerText = "Proficient";
                }

            }
            using (SqlConnection connection = new SqlConnection(builder.ConnectionString))
            {
                string queryBuild = "SELECT proficient FROM SkillProficiency WHERE charID = " + myCharID + "AND skillID = 1010;";
                SqlCommand command = new SqlCommand(queryBuild, connection);
                command.CommandType = System.Data.CommandType.Text;
                connection.Open();
                string temp = "";

                SqlDataReader reader = command.ExecuteReader();
                while (reader.Read())
                {
                    temp += reader["proficient"].ToString();
                }
                int values = 5;
                int.TryParse(temp, out values);
                if (values == 0)
                {
                    p16.InnerText = "Not Proficient";
                }
                else
                {
                    p16.InnerText = "Proficient";
                }

            }
            using (SqlConnection connection = new SqlConnection(builder.ConnectionString))
            {
                string queryBuild = "SELECT proficient FROM SkillProficiency WHERE charID = " + myCharID + "AND skillID = 1011;";
                SqlCommand command = new SqlCommand(queryBuild, connection);
                command.CommandType = System.Data.CommandType.Text;
                connection.Open();
                string temp = "";

                SqlDataReader reader = command.ExecuteReader();
                while (reader.Read())
                {
                    temp += reader["proficient"].ToString();
                }
                int values = 5;
                int.TryParse(temp, out values);
                if (values == 0)
                {
                    p17.InnerText = "Not Proficient";
                }
                else
                {
                    p17.InnerText = "Proficient";
                }

            }
            using (SqlConnection connection = new SqlConnection(builder.ConnectionString))
            {
                string queryBuild = "SELECT proficient FROM SkillProficiency WHERE charID = " + myCharID + "AND skillID = 1012;";
                SqlCommand command = new SqlCommand(queryBuild, connection);
                command.CommandType = System.Data.CommandType.Text;
                connection.Open();
                string temp = "";

                SqlDataReader reader = command.ExecuteReader();
                while (reader.Read())
                {
                    temp += reader["proficient"].ToString();
                }
                int values = 5;
                int.TryParse(temp, out values);
                if (values == 0)
                {
                    p18.InnerText = "Not Proficient";
                }
                else
                {
                    p18.InnerText = "Proficient";
                }

            }
            using (SqlConnection connection = new SqlConnection(builder.ConnectionString))
            {
                string queryBuild = "SELECT proficient FROM SkillProficiency WHERE charID = " + myCharID + "AND skillID = 1013;";
                SqlCommand command = new SqlCommand(queryBuild, connection);
                command.CommandType = System.Data.CommandType.Text;
                connection.Open();
                string temp = "";

                SqlDataReader reader = command.ExecuteReader();
                while (reader.Read())
                {
                    temp += reader["proficient"].ToString();
                }
                int values = 5;
                int.TryParse(temp, out values);
                if (values == 0)
                {
                    p19.InnerText = "Not Proficient";
                }
                else
                {
                    p19.InnerText = "Proficient";
                }

            }
            using (SqlConnection connection = new SqlConnection(builder.ConnectionString))
            {
                string queryBuild = "SELECT proficient FROM SkillProficiency WHERE charID = " + myCharID + "AND skillID = 1014;";
                SqlCommand command = new SqlCommand(queryBuild, connection);
                command.CommandType = System.Data.CommandType.Text;
                connection.Open();
                string temp = "";

                SqlDataReader reader = command.ExecuteReader();
                while (reader.Read())
                {
                    temp += reader["proficient"].ToString();
                }
                int values = 5;
                int.TryParse(temp, out values);
                if (values == 0)
                {
                    p20.InnerText = "Not Proficient";
                }
                else
                {
                    p20.InnerText = "Proficient";
                }

            }
            using (SqlConnection connection = new SqlConnection(builder.ConnectionString))
            {
                string queryBuild = "SELECT proficient FROM SkillProficiency WHERE charID = " + myCharID + "AND skillID = 1015;";
                SqlCommand command = new SqlCommand(queryBuild, connection);
                command.CommandType = System.Data.CommandType.Text;
                connection.Open();
                string temp = "";

                SqlDataReader reader = command.ExecuteReader();
                while (reader.Read())
                {
                    temp += reader["proficient"].ToString();
                }
                int values = 5;
                int.TryParse(temp, out values);
                if (values == 0)
                {
                    p21.InnerText = "Not Proficient";
                }
                else
                {
                    p21.InnerText = "Proficient";
                }

            }
            using (SqlConnection connection = new SqlConnection(builder.ConnectionString))
            {
                string queryBuild = "SELECT proficient FROM SkillProficiency WHERE charID = " + myCharID + "AND skillID = 1016;";
                SqlCommand command = new SqlCommand(queryBuild, connection);
                command.CommandType = System.Data.CommandType.Text;
                connection.Open();
                string temp = "";

                SqlDataReader reader = command.ExecuteReader();
                while (reader.Read())
                {
                    temp += reader["proficient"].ToString();
                }
                int values = 5;
                int.TryParse(temp, out values);
                if (values == 0)
                {
                    p22.InnerText = "Not Proficient";
                }
                else
                {
                    p22.InnerText = "Proficient";
                }

            }
            using (SqlConnection connection = new SqlConnection(builder.ConnectionString))
            {
                string queryBuild = "SELECT proficient FROM SkillProficiency WHERE charID = " + myCharID + "AND skillID = 1017;";
                SqlCommand command = new SqlCommand(queryBuild, connection);
                command.CommandType = System.Data.CommandType.Text;
                connection.Open();
                string temp = "";

                SqlDataReader reader = command.ExecuteReader();
                while (reader.Read())
                {
                    temp += reader["proficient"].ToString();
                }
                int values = 5;
                int.TryParse(temp, out values);
                if (values == 0)
                {
                    p23.InnerText = "Not Proficient";
                }
                else
                {
                    p23.InnerText = "Proficient";
                }

            }
            using (SqlConnection connection = new SqlConnection(builder.ConnectionString))
            {
                string queryBuild = "SELECT proficient FROM SkillProficiency WHERE charID = " + myCharID + "AND skillID = 1018;";
                SqlCommand command = new SqlCommand(queryBuild, connection);
                command.CommandType = System.Data.CommandType.Text;
                connection.Open();
                string temp = "";

                SqlDataReader reader = command.ExecuteReader();
                while (reader.Read())
                {
                    temp += reader["proficient"].ToString();
                }
                int values = 5;
                int.TryParse(temp, out values);
                if (values == 0)
                {
                    p24.InnerText = "Not Proficient";
                }
                else
                {
                    p24.InnerText = "Proficient";
                }

            }
            using (SqlConnection connection = new SqlConnection(builder.ConnectionString))
            {
                string queryBuild = "SELECT proficient FROM SkillProficiency WHERE charID = " + myCharID + "AND skillID = 1019;";
                SqlCommand command = new SqlCommand(queryBuild, connection);
                command.CommandType = System.Data.CommandType.Text;
                connection.Open();
                string temp = "";

                SqlDataReader reader = command.ExecuteReader();
                while (reader.Read())
                {
                    temp += reader["proficient"].ToString();
                }
                int values = 5;
                int.TryParse(temp, out values);
                if (values == 0)
                {
                    p25.InnerText = "Not Proficient";
                }
                else
                {
                    p25.InnerText = "Proficient";
                }

            }


            //str
            using (SqlConnection connection = new SqlConnection(builder.ConnectionString))
            {
                string queryBuild = "select score from AbilityScores where abilityNum =  1002 AND charID =  " + myCharID + ";";
                SqlCommand command = new SqlCommand(queryBuild, connection);
                command.CommandType = System.Data.CommandType.Text;
                connection.Open();
                string temp = "";

                SqlDataReader reader = command.ExecuteReader();
                while (reader.Read())
                {
                    temp += reader["score"].ToString();
                }
                p2.InnerText = temp;
            }

            //dex
            using (SqlConnection connection = new SqlConnection(builder.ConnectionString))
            {
                string queryBuild = "select score from AbilityScores where abilityNum =  1003 AND charID =  " + myCharID + ";";
                SqlCommand command = new SqlCommand(queryBuild, connection);
                command.CommandType = System.Data.CommandType.Text;
                connection.Open();
                string temp = "";

                SqlDataReader reader = command.ExecuteReader();
                while (reader.Read())
                {
                    temp += reader["score"].ToString();
                }
                p3.InnerText = temp;
            }

            //Con
            using (SqlConnection connection = new SqlConnection(builder.ConnectionString))
            {
                string queryBuild = "select score from AbilityScores where abilityNum =  1004 AND charID =  " + myCharID + ";";
                SqlCommand command = new SqlCommand(queryBuild, connection);
                command.CommandType = System.Data.CommandType.Text;
                connection.Open();
                string temp = "";

                SqlDataReader reader = command.ExecuteReader();
                while (reader.Read())
                {
                    temp += reader["score"].ToString();
                }
                p4.InnerText = temp;
            }

            //Int
            using (SqlConnection connection = new SqlConnection(builder.ConnectionString))
            {
                string queryBuild = "select score from AbilityScores where abilityNum =  1005 AND charID =  " + myCharID + ";";
                SqlCommand command = new SqlCommand(queryBuild, connection);
                command.CommandType = System.Data.CommandType.Text;
                connection.Open();
                string temp = "";

                SqlDataReader reader = command.ExecuteReader();
                while (reader.Read())
                {
                    temp += reader["score"].ToString();
                }
                p5.InnerText = temp;
            }

            //Wis
            using (SqlConnection connection = new SqlConnection(builder.ConnectionString))
            {
                string queryBuild = "select score from AbilityScores where abilityNum =  1006 AND charID =  " + myCharID + ";";
                SqlCommand command = new SqlCommand(queryBuild, connection);
                command.CommandType = System.Data.CommandType.Text;
                connection.Open();
                string temp = "";

                SqlDataReader reader = command.ExecuteReader();
                while (reader.Read())
                {
                    temp += reader["score"].ToString();
                }
                p6.InnerText = temp;
            }

            //Cha
            using (SqlConnection connection = new SqlConnection(builder.ConnectionString))
            {
                string queryBuild = "select score from AbilityScores where abilityNum =  1007 AND charID =  " + myCharID + ";";
                SqlCommand command = new SqlCommand(queryBuild, connection);
                command.CommandType = System.Data.CommandType.Text;
                connection.Open();
                string temp = "";

                SqlDataReader reader = command.ExecuteReader();
                while (reader.Read())
                {
                    temp += reader["score"].ToString();
                }
                p7.InnerText = temp;
            }

            using (SqlConnection connection = new SqlConnection(builder.ConnectionString))
            {
                string queryBuild = "SELECT proficient FROM SkillProficiency WHERE charID = " + myCharID + "AND skillID = 1020;";
                SqlCommand command = new SqlCommand(queryBuild, connection);
                command.CommandType = System.Data.CommandType.Text;
                connection.Open();
                string temp = "";

                SqlDataReader reader = command.ExecuteReader();
                while (reader.Read())
                {
                    temp += reader["proficient"].ToString();
                }

                int values = 5;
                int.TryParse(temp, out values);
                if (values == 0)
                {
                    p26.InnerText = "Not Proficient";
                }
                else
                {
                    p26.InnerText = "Proficient";
                }

            }



















        }
    }
}