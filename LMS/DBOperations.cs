using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;

namespace LMS
{
    public class DBOperations
    {
        string ConnectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

        string AutoId = DateTime.Now.Ticks.ToString("X");



        public DataTable Login(string username, string password, int role)
        {
            DataTable dt = new DataTable();
            using (SqlConnection con = new SqlConnection(ConnectionString))
            using (SqlCommand cmd = new SqlCommand("[LMS_Triopod_User].[PROCLOGIN]", con))
            {

                using (SqlDataAdapter sda = new SqlDataAdapter())
                {
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.Add("@Username", SqlDbType.NVarChar).Value = username;
                    cmd.Parameters.Add("@Password", SqlDbType.NVarChar).Value = password;
                    cmd.Parameters.Add("@UserRole", SqlDbType.Int).Value = role;
                    cmd.Parameters.Add("@option", SqlDbType.Int).Value = 1;
                    try
                    {
                        con.Open();
                        sda.SelectCommand = cmd;
                        sda.Fill(dt);

                    }
                    catch (SqlException ex)
                    {
                        LogError(ex);
                        return null;
                    }
                    finally
                    {
                        con.Close();
                    }
                    return dt;
                }
            }
        }

        public DataTable LoginAdmin(string username, string password)
        {
            DataTable dt = new DataTable();
            using (SqlConnection con = new SqlConnection(ConnectionString))
            using (SqlCommand cmd = new SqlCommand("[LMS_Triopod_User].[PROCLOGIN]", con))
            {

                using (SqlDataAdapter sda = new SqlDataAdapter())
                {
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.Add("@Username", SqlDbType.NVarChar).Value = username;
                    cmd.Parameters.Add("@Password", SqlDbType.NVarChar).Value = password;
                    cmd.Parameters.Add("@option", SqlDbType.Int).Value = 2;
                    try
                    {
                        con.Open();
                        sda.SelectCommand = cmd;
                        sda.Fill(dt);

                    }
                    catch (SqlException ex)
                    {
                        LogError(ex);
                        return null;
                    }
                    finally
                    {
                        con.Close();
                    }
                    return dt;
                }
            }
        }
        public string changepassword(string userid, string currentpassword, string newpassword)
        {

            using (SqlConnection con = new SqlConnection(ConnectionString))
            using (SqlCommand cmd = new SqlCommand("[LMS_Triopod_User].[PROCUSER]", con))
            {
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.Add("@USERID", SqlDbType.Int).Value = int.Parse(userid);
                cmd.Parameters.Add("@CURRENTPASS", SqlDbType.NVarChar).Value = currentpassword;
                cmd.Parameters.Add("@NEWPASS", SqlDbType.NVarChar).Value = newpassword;
                cmd.Parameters.Add("@option", SqlDbType.Int).Value = 1;
                cmd.Parameters.Add("@OUTPUTMESSAGE", SqlDbType.Char, 500);
                cmd.Parameters["@OUTPUTMESSAGE"].Direction = ParameterDirection.Output;

                try
                {
                    con.Open();
                    cmd.ExecuteNonQuery();
                    string OUTPUTMESSAGE = (string)cmd.Parameters["@OUTPUTMESSAGE"].Value;

                    return OUTPUTMESSAGE.Trim();
                }
                catch (SqlException ex)
                {
                    LogError(ex);
                    return "ERROR";

                }
                finally
                {
                    con.Close();
                }
            }
        }

        public string AddLab(string username, string password, string labname, string ownername, string mobile, string phone, string email, string state, string city, string pincode, string address, string subscriptionvalidto, string logourl, string website)
        {

            using (SqlConnection con = new SqlConnection(ConnectionString))
            using (SqlCommand cmd = new SqlCommand("[LMS_Triopod_User].[PROCLAB]", con))
            {
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.Add("@username", SqlDbType.NVarChar).Value = username;

                cmd.Parameters.Add("@password", SqlDbType.NVarChar).Value = password;
                cmd.Parameters.Add("@labname", SqlDbType.NVarChar).Value = labname;

                cmd.Parameters.Add("@ownername", SqlDbType.NVarChar).Value = ownername;
                cmd.Parameters.Add("@Email", SqlDbType.NVarChar).Value = email;

                cmd.Parameters.Add("@Mobile", SqlDbType.NVarChar).Value = mobile;

                cmd.Parameters.Add("@phone", SqlDbType.NVarChar).Value = phone;
                cmd.Parameters.Add("@State", SqlDbType.NVarChar).Value = state;

                cmd.Parameters.Add("@City", SqlDbType.NVarChar).Value = city;

                cmd.Parameters.Add("@Pincode", SqlDbType.NVarChar).Value = pincode;

                cmd.Parameters.Add("@Address", SqlDbType.NVarChar).Value = address;
                cmd.Parameters.Add("@subscriptionvalidto", SqlDbType.DateTime).Value = subscriptionvalidto;

                cmd.Parameters.Add("@logourl", SqlDbType.NVarChar).Value = logourl;

                cmd.Parameters.Add("@website", SqlDbType.NVarChar).Value = website;


                cmd.Parameters.Add("@option", SqlDbType.Int).Value = 1;
                cmd.Parameters.Add("@OUTPUTMESSAGE", SqlDbType.Char, 100);
                cmd.Parameters["@OUTPUTMESSAGE"].Direction = ParameterDirection.Output;

                try
                {
                    con.Open();
                    cmd.ExecuteNonQuery();

                    string OUTPUTMESSAGE = (string)cmd.Parameters["@OUTPUTMESSAGE"].Value;
                    return OUTPUTMESSAGE.Trim();
                }
                catch (SqlException ex)
                {
                    LogError(ex);
                    return "ERROR";

                }
                finally
                {
                    con.Close();
                }
            }
        }
        public string UpdateLab(string labid, string labname, string ownername, string mobile, string phone, string email, string state, string city, string pincode, string address, string subscriptionvalidto, string logourl, string website, string status)
        {

            using (SqlConnection con = new SqlConnection(ConnectionString))
            using (SqlCommand cmd = new SqlCommand("[LMS_Triopod_User].[PROCLAB]", con))
            {
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.Add("@labid", SqlDbType.NVarChar).Value = int.Parse(labid);
                cmd.Parameters.Add("@labname", SqlDbType.NVarChar).Value = labname;

                cmd.Parameters.Add("@ownername", SqlDbType.NVarChar).Value = ownername;
                cmd.Parameters.Add("@Email", SqlDbType.NVarChar).Value = email;

                cmd.Parameters.Add("@Mobile", SqlDbType.NVarChar).Value = mobile;

                cmd.Parameters.Add("@phone", SqlDbType.NVarChar).Value = phone;
                cmd.Parameters.Add("@State", SqlDbType.NVarChar).Value = state;

                cmd.Parameters.Add("@City", SqlDbType.NVarChar).Value = city;

                cmd.Parameters.Add("@Pincode", SqlDbType.NVarChar).Value = pincode;

                cmd.Parameters.Add("@Address", SqlDbType.NVarChar).Value = address;
                cmd.Parameters.Add("@subscriptionvalidto", SqlDbType.DateTime).Value = subscriptionvalidto;

                cmd.Parameters.Add("@logourl", SqlDbType.NVarChar).Value = logourl;

                cmd.Parameters.Add("@website", SqlDbType.NVarChar).Value = website;
                cmd.Parameters.Add("@status", SqlDbType.Bit).Value = status;

                cmd.Parameters.Add("@option", SqlDbType.Int).Value = 3;
                cmd.Parameters.Add("@OUTPUTMESSAGE", SqlDbType.Char, 100);
                cmd.Parameters["@OUTPUTMESSAGE"].Direction = ParameterDirection.Output;

                try
                {
                    con.Open();
                    cmd.ExecuteNonQuery();
                    string OUTPUTMESSAGE = (string)cmd.Parameters["@OUTPUTMESSAGE"].Value;

                    return OUTPUTMESSAGE.Trim();
                }
                catch (SqlException ex)
                {
                    LogError(ex);
                    return "ERROR";

                }
                finally
                {
                    con.Close();
                }
            }
        }
        public DataTable GetLab()
        {
            DataTable dt = new DataTable();
            using (SqlConnection con = new SqlConnection(ConnectionString))
            using (SqlCommand cmd = new SqlCommand("[LMS_Triopod_User].[PROCLAB]", con))
            {

                using (SqlDataAdapter sda = new SqlDataAdapter())
                {
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.Add("@option", SqlDbType.Int).Value = 2;

                    try
                    {
                        con.Open();
                        sda.SelectCommand = cmd;
                        sda.Fill(dt);

                    }
                    catch (SqlException ex)
                    {
                        LogError(ex);
                        return null;
                    }
                    finally
                    {
                        con.Close();
                    }
                    return dt;
                }
            }
        }

        public DataSet BindAdminDashboard()
        {
            DataSet ds = new DataSet();


            using (SqlConnection con = new SqlConnection(ConnectionString))
            using (SqlCommand cmd = new SqlCommand("[LMS_Triopod_User].[PROCBINDPAGE]", con))
            {
                using (SqlDataAdapter sda = new SqlDataAdapter())
                {
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.Add("@option", SqlDbType.Int).Value = 3;
                    try
                    {
                        con.Open();
                        sda.SelectCommand = cmd;
                        sda.Fill(ds);

                    }
                    catch (SqlException ex)
                    {
                        LogError(ex);
                        return null;
                    }
                    finally
                    {
                        con.Close();
                    }
                    return ds;

                }
            }
        }
        public DataSet BindDashboard(string labid)
        {
            DataSet ds = new DataSet();


            using (SqlConnection con = new SqlConnection(ConnectionString))
            using (SqlCommand cmd = new SqlCommand("[LMS_Triopod_User].[PROCBINDPAGE]", con))
            {
                using (SqlDataAdapter sda = new SqlDataAdapter())
                {
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.Add("@LabID", SqlDbType.Int).Value = int.Parse(labid);
                    cmd.Parameters.Add("@option", SqlDbType.Int).Value = 1;
                    try
                    {
                        con.Open();
                        sda.SelectCommand = cmd;
                        sda.Fill(ds);

                    }
                    catch (SqlException ex)
                    {
                        LogError(ex);
                        return null;
                    }
                    finally
                    {
                        con.Close();
                    }
                    return ds;

                }
            }
        }
        public string AddDoctor(string name, string degree, string city)
        {
            using (SqlConnection con = new SqlConnection(ConnectionString))
            using (SqlCommand cmd = new SqlCommand("[LMS_Triopod_User].[PROCDOCTOR]", con))
            {
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.Add("@name", SqlDbType.NVarChar).Value = name;

                cmd.Parameters.Add("@degree", SqlDbType.NVarChar).Value = degree;

                cmd.Parameters.Add("@city", SqlDbType.NVarChar).Value = city;


                cmd.Parameters.Add("@option", SqlDbType.Int).Value = 1;

                try
                {
                    con.Open();
                    cmd.ExecuteNonQuery();
                    return "SUCCESS";
                }
                catch (SqlException ex)
                {
                    LogError(ex);
                    return "ERROR";

                }
                finally
                {
                    con.Close();
                }
            }
        }
        public string AddTestCenter(string name, string ccode, string labid)
        {
            using (SqlConnection con = new SqlConnection(ConnectionString))
            using (SqlCommand cmd = new SqlCommand("[LMS_Triopod_User].[PROCTESTCENTER]", con))
            {
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.Add("@name", SqlDbType.NVarChar).Value = name;

                cmd.Parameters.Add("@ccode", SqlDbType.NVarChar).Value = ccode;

                cmd.Parameters.Add("@labid", SqlDbType.Int).Value = int.Parse(labid);


                cmd.Parameters.Add("@option", SqlDbType.Int).Value = 1;

                try
                {
                    con.Open();
                    cmd.ExecuteNonQuery();
                    return "SUCCESS";
                }
                catch (SqlException ex)
                {
                    LogError(ex);
                    return "ERROR";

                }
                finally
                {
                    con.Close();
                }
            }
        }
        public string AddPatient(string title, string name, string email, string mobile, string aadhar, string age, string agetype, string sex, string state, string city, string pincode, string address, string labid, string userid)
        {
            using (SqlConnection con = new SqlConnection(ConnectionString))
            using (SqlCommand cmd = new SqlCommand("[LMS_Triopod_User].[PROCPATIENT]", con))
            {
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.Add("@Title", SqlDbType.NVarChar).Value = title;

                cmd.Parameters.Add("@Name", SqlDbType.NVarChar).Value = name;

                cmd.Parameters.Add("@Email", SqlDbType.NVarChar).Value = email;

                cmd.Parameters.Add("@Mobile", SqlDbType.NVarChar).Value = mobile;

                cmd.Parameters.Add("@Aadhar", SqlDbType.NVarChar).Value = aadhar;

                cmd.Parameters.Add("@Age", SqlDbType.Int).Value = int.Parse(age);

                cmd.Parameters.Add("@AgeType", SqlDbType.NVarChar).Value = agetype;

                cmd.Parameters.Add("@Sex", SqlDbType.NVarChar).Value = sex;

                cmd.Parameters.Add("@State", SqlDbType.NVarChar).Value = state;

                cmd.Parameters.Add("@City", SqlDbType.NVarChar).Value = city;

                cmd.Parameters.Add("@Pincode", SqlDbType.NVarChar).Value = pincode;

                cmd.Parameters.Add("@Address", SqlDbType.NVarChar).Value = address;

                cmd.Parameters.Add("@LabID", SqlDbType.Int).Value = int.Parse(labid);

                cmd.Parameters.Add("@UserID", SqlDbType.Int).Value = int.Parse(userid);
                cmd.Parameters.Add("@option", SqlDbType.Int).Value = 1;
                cmd.Parameters.Add("@OUTPUTMESSAGE", SqlDbType.Char, 100);
                cmd.Parameters["@OUTPUTMESSAGE"].Direction = ParameterDirection.Output;

                try
                {
                    con.Open();
                    cmd.ExecuteNonQuery();

                    string OUTPUTMESSAGE = (string)cmd.Parameters["@OUTPUTMESSAGE"].Value;
                    return OUTPUTMESSAGE.Trim();
                }
                catch (SqlException ex)
                {
                    LogError(ex);
                    return "ERROR";

                }
                finally
                {
                    con.Close();
                }
            }
        }
        public DataTable PatientList(string labid)
        {
            DataTable dt = new DataTable();
            using (SqlConnection con = new SqlConnection(ConnectionString))
            using (SqlCommand cmd = new SqlCommand("[LMS_Triopod_User].[PROCPATIENT]", con))
            {

                using (SqlDataAdapter sda = new SqlDataAdapter())
                {
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.Add("@LabID", SqlDbType.Int).Value = int.Parse(labid);
                    cmd.Parameters.Add("@option", SqlDbType.Int).Value = 2;

                    try
                    {
                        con.Open();
                        sda.SelectCommand = cmd;
                        sda.Fill(dt);

                    }
                    catch (SqlException ex)
                    {
                        LogError(ex);
                        return null;
                    }
                    finally
                    {
                        con.Close();
                    }
                    return dt;
                }
            }
        }
        public DataTable PatientById(string patientid, string labid)
        {
            DataTable dt = new DataTable();
            using (SqlConnection con = new SqlConnection(ConnectionString))
            using (SqlCommand cmd = new SqlCommand("[LMS_Triopod_User].[PROCPATIENT]", con))
            {

                using (SqlDataAdapter sda = new SqlDataAdapter())
                {
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.Add("@PatientID", SqlDbType.Int).Value = int.Parse(patientid);
                    cmd.Parameters.Add("@option", SqlDbType.Int).Value = 3;
                    try
                    {
                        con.Open();
                        sda.SelectCommand = cmd;
                        sda.Fill(dt);

                    }
                    catch (SqlException ex)
                    {
                        LogError(ex);
                        return null;
                    }
                    finally
                    {
                        con.Close();
                    }
                    return dt;
                }
            }
        }

        public string AddTestGroup(string groupname, string subgroupid)
        {
            using (SqlConnection con = new SqlConnection(ConnectionString))
            using (SqlCommand cmd = new SqlCommand("[LMS_Triopod_User].[PROCTEST]", con))
            {
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.Add("@TestGroupName", SqlDbType.NVarChar).Value = groupname;
                cmd.Parameters.Add("@SubGroupId", SqlDbType.NVarChar).Value = int.Parse(subgroupid);
                cmd.Parameters.Add("@option", SqlDbType.Int).Value = 1;

                try
                {
                    con.Open();
                    cmd.ExecuteNonQuery();

                    return "SUCCESS";
                }
                catch (SqlException ex)
                {
                    LogError(ex);
                    return "ERROR";

                }
                finally
                {
                    con.Close();
                }
            }
        }
        public DataTable GetTestGroup(string TestGroupId, int option)
        {
            DataTable dt = new DataTable();
            using (SqlConnection con = new SqlConnection(ConnectionString))
            using (SqlCommand cmd = new SqlCommand("[LMS_Triopod_User].[PROCTEST]", con))
            {

                using (SqlDataAdapter sda = new SqlDataAdapter())
                {
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.Add("@TestGroupId", SqlDbType.Int).Value = int.Parse(TestGroupId);
                    cmd.Parameters.Add("@option", SqlDbType.Int).Value = option;
                    try
                    {
                        con.Open();
                        sda.SelectCommand = cmd;
                        sda.Fill(dt);

                    }
                    catch (SqlException ex)
                    {
                        LogError(ex);
                        return null;
                    }
                    finally
                    {
                        con.Close();
                    }
                    return dt;
                }
            }
        }

        public string AddTest(string testname, string testgroupid, string price, string normalrange, string defaultresult, string labid, string parentgroupid, string IsclubofClub, string testsortname)
        {
            using (SqlConnection con = new SqlConnection(ConnectionString))
            using (SqlCommand cmd = new SqlCommand("[LMS_Triopod_User].[PROCTEST]", con))
            {
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.Add("@TestName", SqlDbType.NVarChar).Value = testname;
                cmd.Parameters.Add("@TestSortName", SqlDbType.NVarChar).Value = testsortname;
                cmd.Parameters.Add("@TestGroupId", SqlDbType.NVarChar).Value = int.Parse(testgroupid);
                cmd.Parameters.Add("@ParentGroup_id", SqlDbType.NVarChar).Value = int.Parse(parentgroupid);
                cmd.Parameters.Add("@Price", SqlDbType.Int).Value = int.Parse(price);
                cmd.Parameters.Add("@NormalRange", SqlDbType.NVarChar).Value = normalrange;
                cmd.Parameters.Add("@DefaultResult", SqlDbType.NVarChar).Value = defaultresult;
                cmd.Parameters.Add("@LabID", SqlDbType.Int).Value = int.Parse(labid);
                cmd.Parameters.Add("@IsclubofClub", SqlDbType.Int).Value = int.Parse(IsclubofClub);

                cmd.Parameters.Add("@option", SqlDbType.Int).Value = 4;
                try
                {
                    con.Open();
                    cmd.ExecuteNonQuery();

                    return "SUCCESS";
                }
                catch (SqlException ex)
                {
                    LogError(ex);
                    return "ERROR";

                }
                finally
                {
                    con.Close();
                }
            }
        }
        public string AddClubTest(string testname, string testgroupid, string price, string normalrange, string labid, DataTable clubtest, string parentgroupid, string IsclubofClub, string testsortname)
        {

            using (SqlConnection con = new SqlConnection(ConnectionString))
            using (SqlCommand cmd = new SqlCommand("[LMS_Triopod_User].[PROCTEST]", con))
            {
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.Add("@TestName", SqlDbType.NVarChar).Value = testname;
                cmd.Parameters.Add("@TestSortName", SqlDbType.NVarChar).Value = testsortname;
                cmd.Parameters.Add("@TestGroupId", SqlDbType.NVarChar).Value = int.Parse(testgroupid);
                cmd.Parameters.Add("@ParentGroup_id", SqlDbType.NVarChar).Value = int.Parse(parentgroupid);
                cmd.Parameters.Add("@Price", SqlDbType.Int).Value = int.Parse(price);
                cmd.Parameters.Add("@NormalRange", SqlDbType.NVarChar).Value = normalrange;

                cmd.Parameters.Add("@LabID", SqlDbType.Int).Value = int.Parse(labid);
                cmd.Parameters.Add("@IsclubofClub", SqlDbType.Int).Value = int.Parse(IsclubofClub);
                cmd.Parameters.AddWithValue("@TableClubTest", clubtest);
                cmd.Parameters.Add("@option", SqlDbType.Int).Value = 5;

                try
                {
                    con.Open();
                    cmd.ExecuteScalar();
                    return "SUCCESS";
                }
                catch (SqlException ex)
                {

                    LogError(ex);
                    return "ERROR";
                }
                finally
                {
                    con.Close();
                }
            }
        }

        public string UpdateTest(string testid, string testname, string price, string normalrange, string status)
        {
            using (SqlConnection con = new SqlConnection(ConnectionString))
            using (SqlCommand cmd = new SqlCommand("[LMS_Triopod_User].[PROCTEST]", con))
            {
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.Add("@TestName", SqlDbType.NVarChar).Value = testname;
                cmd.Parameters.Add("@Price", SqlDbType.Int).Value = int.Parse(price);
                cmd.Parameters.Add("@TestID", SqlDbType.Int).Value = int.Parse(testid);
                cmd.Parameters.Add("@Status", SqlDbType.Bit).Value = status;
                cmd.Parameters.Add("@NormalRange", SqlDbType.NVarChar).Value = normalrange;
                cmd.Parameters.Add("@option", SqlDbType.Int).Value = 8;
                try
                {
                    con.Open();
                    cmd.ExecuteNonQuery();

                    return "SUCCESS";
                }
                catch (SqlException ex)
                {
                    LogError(ex);
                    return "ERROR";

                }
                finally
                {
                    con.Close();
                }
            }
        }

        public string DeleteTest(string testid)
        {
            using (SqlConnection con = new SqlConnection(ConnectionString))
            using (SqlCommand cmd = new SqlCommand("[LMS_Triopod_User].[PROCTEST]", con))
            {
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.Add("@TestID", SqlDbType.Int).Value = int.Parse(testid);
                cmd.Parameters.Add("@option", SqlDbType.Int).Value = 9;

                try
                {
                    con.Open();
                    cmd.ExecuteNonQuery();

                    return "SUCCESS";

                }
                catch (SqlException ex)
                {

                    LogError(ex);
                    return "ERROR";

                }
                finally
                {
                    con.Close();
                }
            }
        }
        public DataTable GetTest(string labid)
        {
            DataTable dt = new DataTable();
            using (SqlConnection con = new SqlConnection(ConnectionString))
            using (SqlCommand cmd = new SqlCommand("[LMS_Triopod_User].[PROCTEST]", con))
            {

                using (SqlDataAdapter sda = new SqlDataAdapter())
                {
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.Add("@LabID", SqlDbType.Int).Value = int.Parse(labid);
                    cmd.Parameters.Add("@option", SqlDbType.Int).Value = 6;
                    try
                    {
                        con.Open();
                        sda.SelectCommand = cmd;
                        sda.Fill(dt);

                    }
                    catch (SqlException ex)
                    {
                        LogError(ex);
                        return null;
                    }
                    finally
                    {
                        con.Close();
                    }
                    return dt;
                }
            }
        }

        public DataTable GetTestResult(string orderid, string labid)
        {
            DataTable dt = new DataTable();
            using (SqlConnection con = new SqlConnection(ConnectionString))
            using (SqlCommand cmd = new SqlCommand("[LMS_Triopod_User].[PRORESULT]", con))
            {

                using (SqlDataAdapter sda = new SqlDataAdapter())
                {
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.Add("@LabID", SqlDbType.Int).Value = int.Parse(labid);
                    cmd.Parameters.Add("@OrderID", SqlDbType.Int).Value = int.Parse(orderid);
                    cmd.Parameters.Add("@option", SqlDbType.Int).Value = 2;
                    try
                    {
                        con.Open();
                        sda.SelectCommand = cmd;
                        sda.Fill(dt);

                    }
                    catch (SqlException ex)
                    {
                        LogError(ex);
                        return null;
                    }
                    finally
                    {
                        con.Close();
                    }
                    return dt;
                }
            }
        }
        public DataTable GetClubTest(string testid)
        {
            DataTable dt = new DataTable();

            SqlDataReader dr;
            using (SqlConnection con = new SqlConnection(ConnectionString))
            using (SqlCommand cmd = new SqlCommand("[LMS_Triopod_User].[PROCTEST]", con))
            {
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.Add("@TestID", SqlDbType.Int).Value = int.Parse(testid);
                cmd.Parameters.Add("@option", SqlDbType.Int).Value = 7;
                try
                {
                    con.Open();
                    dr = cmd.ExecuteReader();
                    if (dr.HasRows)
                    {
                        dt.Load(dr);
                    }
                }
                catch (SqlException ex)
                {
                    LogError(ex);
                    return null;
                }
                finally
                {
                    con.Close();
                }
                return dt;
            }
        }

        public DataSet BindNewOrderPage(string labid)
        {
            DataSet ds = new DataSet();
            using (SqlConnection con = new SqlConnection(ConnectionString))
            using (SqlCommand cmd = new SqlCommand("[LMS_Triopod_User].[PROCBINDPAGE]", con))
            {

                using (SqlDataAdapter sda = new SqlDataAdapter())
                {
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.Add("@LabID", SqlDbType.Int).Value = int.Parse(labid);
                    //cmd.Parameters.Add("@PatientID", SqlDbType.Int).Value = int.Parse(patientid);
                    cmd.Parameters.Add("@option", SqlDbType.Int).Value = 2;
                    try
                    {
                        con.Open();
                        sda.SelectCommand = cmd;
                        sda.Fill(ds);

                    }
                    catch (SqlException ex)
                    {
                        LogError(ex);
                        return null;
                    }
                    finally
                    {
                        con.Close();
                    }
                    return ds;
                }
            }
        }

        public string AddOrder(string labid, string patientid, string doctorname, string totalamount, string paidamount, string duesamount, DataTable test, DataTable clubtest, string referredto, string discount)
        {
            using (SqlConnection con = new SqlConnection(ConnectionString))
            using (SqlCommand cmd = new SqlCommand("[LMS_Triopod_User].[PROCORDER]", con))
            {
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.Add("@LabID", SqlDbType.Int).Value = int.Parse(labid);
                cmd.Parameters.Add("@PatientID", SqlDbType.Int).Value = int.Parse(patientid);
                cmd.Parameters.Add("@Amount", SqlDbType.Money).Value = totalamount;
                cmd.Parameters.Add("@Discount", SqlDbType.Money).Value = discount;
                cmd.Parameters.Add("@Paid", SqlDbType.Money).Value = paidamount;
                cmd.Parameters.Add("@dues", SqlDbType.Money).Value = duesamount;
                cmd.Parameters.Add("@ReferredBy", SqlDbType.NVarChar).Value = doctorname;
                cmd.Parameters.Add("@ReferredTo", SqlDbType.NVarChar).Value = referredto;
                cmd.Parameters.AddWithValue("@TableOrderTest", test);
                cmd.Parameters.AddWithValue("@TableOrderClubTest", clubtest);

                cmd.Parameters.Add("@option", SqlDbType.Int).Value = 2;

                cmd.Parameters.Add("@OUTPUTMESSAGE", SqlDbType.Char, 1000);
                cmd.Parameters["@OUTPUTMESSAGE"].Direction = ParameterDirection.Output;

                try
                {
                    con.Open();
                    cmd.ExecuteNonQuery();

                    string OUTPUTMESSAGE = (string)cmd.Parameters["@OUTPUTMESSAGE"].Value;
                    return OUTPUTMESSAGE.Trim();

                }
                catch (SqlException ex)
                {
                    LogError(ex);
                    return "ERROR";

                }
                finally
                {
                    con.Close();
                }
            }
        }
        public DataTable GetOrder(string labid)
        {
            DataTable dt = new DataTable();
            using (SqlConnection con = new SqlConnection(ConnectionString))
            using (SqlCommand cmd = new SqlCommand("[LMS_Triopod_User].[PROCORDER]", con))
            {

                using (SqlDataAdapter sda = new SqlDataAdapter())
                {
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.Add("@LabID", SqlDbType.Int).Value = int.Parse(labid);
                    cmd.Parameters.Add("@option", SqlDbType.Int).Value = 3;
                    try
                    {
                        con.Open();
                        sda.SelectCommand = cmd;
                        sda.Fill(dt);

                    }
                    catch (SqlException ex)
                    {
                        LogError(ex);
                        return null;
                    }
                    finally
                    {
                        con.Close();
                    }
                    return dt;
                }
            }
        }
        public DataTable PatientOrder(string labid, string patientid)
        {
            DataTable dt = new DataTable();
            using (SqlConnection con = new SqlConnection(ConnectionString))
            using (SqlCommand cmd = new SqlCommand("[LMS_Triopod_User].[PROCORDER]", con))
            {

                using (SqlDataAdapter sda = new SqlDataAdapter())
                {
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.Add("@LabID", SqlDbType.Int).Value = int.Parse(labid);
                    cmd.Parameters.Add("@PatientID", SqlDbType.Int).Value = int.Parse(patientid);
                    cmd.Parameters.Add("@option", SqlDbType.Int).Value = 8;
                    try
                    {
                        con.Open();
                        sda.SelectCommand = cmd;
                        sda.Fill(dt);

                    }
                    catch (SqlException ex)
                    {
                        LogError(ex);
                        return null;
                    }
                    finally
                    {
                        con.Close();
                    }
                    return dt;
                }
            }
        }

        public DataSet GetOrderReportNotGenerated(string labid)
        {
            DataSet ds = new DataSet();
            using (SqlConnection con = new SqlConnection(ConnectionString))
            using (SqlCommand cmd = new SqlCommand("[LMS_Triopod_User].[PROCORDER]", con))
            {

                using (SqlDataAdapter sda = new SqlDataAdapter())
                {
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.Add("@LabID", SqlDbType.Int).Value = int.Parse(labid);
                    cmd.Parameters.Add("@option", SqlDbType.Int).Value = 4;
                    try
                    {
                        con.Open();
                        sda.SelectCommand = cmd;
                        sda.Fill(ds);

                    }
                    catch (SqlException ex)
                    {
                        LogError(ex);
                        return null;
                    }
                    finally
                    {
                        con.Close();
                    }
                    return ds;
                }
            }
        }

        public DataTable GetOrderReportGenerated(string labid)
        {
            DataTable dt = new DataTable();
            using (SqlConnection con = new SqlConnection(ConnectionString))
            using (SqlCommand cmd = new SqlCommand("[LMS_Triopod_User].[PROCORDER]", con))
            {

                using (SqlDataAdapter sda = new SqlDataAdapter())
                {
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.Add("@LabID", SqlDbType.Int).Value = int.Parse(labid);
                    cmd.Parameters.Add("@option", SqlDbType.Int).Value = 6;
                    try
                    {
                        con.Open();
                        sda.SelectCommand = cmd;
                        sda.Fill(dt);

                    }
                    catch (SqlException ex)
                    {
                        LogError(ex);
                        return null;
                    }
                    finally
                    {
                        con.Close();
                    }
                    return dt;
                }
            }
        }

        public string AddTestResult(string orderid, string reportnotes, DataTable result)
        {

            using (SqlConnection con = new SqlConnection(ConnectionString))
            using (SqlCommand cmd = new SqlCommand("[LMS_Triopod_User].[PRORESULT]", con))
            {
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.Add("@OrderID", SqlDbType.Int).Value = int.Parse(orderid);
                cmd.Parameters.Add("@ReportNotes", SqlDbType.NVarChar).Value = reportnotes;
                cmd.Parameters.AddWithValue("@TableResult", result);
                cmd.Parameters.Add("@option", SqlDbType.Int).Value = 1;

                cmd.Parameters.Add("@OUTPUTMESSAGE", SqlDbType.Char, 1000);
                cmd.Parameters["@OUTPUTMESSAGE"].Direction = ParameterDirection.Output;

                try
                {
                    con.Open();
                    cmd.ExecuteNonQuery();

                    string OUTPUTMESSAGE = (string)cmd.Parameters["@OUTPUTMESSAGE"].Value;
                    return OUTPUTMESSAGE.Trim();

                }
                catch (SqlException ex)
                {

                    LogError(ex);
                    return "ERROR";
                }
                finally
                {
                    con.Close();
                }
            }
        }

        public string UpdateTestResult(DataTable result)
        {

            using (SqlConnection con = new SqlConnection(ConnectionString))
            using (SqlCommand cmd = new SqlCommand("[LMS_Triopod_User].[PRORESULT]", con))
            {
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@TableUpdateResult", result);
                cmd.Parameters.Add("@option", SqlDbType.Int).Value = 3;

                try
                {
                    con.Open();
                    cmd.ExecuteNonQuery();

                    return "SUCCESS";

                }
                catch (SqlException ex)
                {

                    LogError(ex);
                    return "ERROR";
                }
                finally
                {
                    con.Close();
                }
            }
        }

        public DataSet GenerateInvoice(string labid, string orderid)
        {
            DataSet ds = new DataSet();
            using (SqlConnection con = new SqlConnection(ConnectionString))
            using (SqlCommand cmd = new SqlCommand("[LMS_Triopod_User].[PROCORDER]", con))
            {

                using (SqlDataAdapter sda = new SqlDataAdapter())
                {
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.Add("@LabID", SqlDbType.Int).Value = int.Parse(labid);
                    cmd.Parameters.Add("@orderid", SqlDbType.Int).Value = int.Parse(orderid);
                    cmd.Parameters.Add("@option", SqlDbType.Int).Value = 5;
                    try
                    {
                        con.Open();
                        sda.SelectCommand = cmd;
                        sda.Fill(ds);

                    }
                    catch (SqlException ex)
                    {
                        LogError(ex);
                        return null;
                    }
                    finally
                    {
                        con.Close();
                    }
                    return ds;
                }
            }
        }

        public DataSet GenerateReport(string labid, string orderid)
        {
            DataSet ds = new DataSet();
            using (SqlConnection con = new SqlConnection(ConnectionString))
            using (SqlCommand cmd = new SqlCommand("[LMS_Triopod_User].[PROCORDER]", con))
            {

                using (SqlDataAdapter sda = new SqlDataAdapter())
                {
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.Add("@LabID", SqlDbType.Int).Value = int.Parse(labid);
                    cmd.Parameters.Add("@orderid", SqlDbType.Int).Value = int.Parse(orderid);
                    cmd.Parameters.Add("@option", SqlDbType.Int).Value = 7;
                    try
                    {
                        con.Open();
                        sda.SelectCommand = cmd;
                        sda.Fill(ds);

                    }
                    catch (SqlException ex)
                    {
                        LogError(ex);
                        return null;
                    }
                    finally
                    {
                        con.Close();
                    }
                    return ds;
                }
            }
        }
        public string Labsetting(string labid, string header, string footer, string status)
        {

            using (SqlConnection con = new SqlConnection(ConnectionString))
            using (SqlCommand cmd = new SqlCommand("[LMS_Triopod_User].[PROCSETTING]", con))
            {
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.Add("@LabID", SqlDbType.Int).Value = int.Parse(labid);
                cmd.Parameters.Add("@Header", SqlDbType.NVarChar).Value = header;
                cmd.Parameters.Add("@Footer", SqlDbType.NVarChar).Value = footer;
                cmd.Parameters.Add("@IsEnabeled", SqlDbType.Bit).Value = status;
                cmd.Parameters.Add("@option", SqlDbType.Int).Value = 1;

                //cmd.Parameters.Add("@OUTPUTMESSAGE", SqlDbType.Char, 1000);
                //cmd.Parameters["@OUTPUTMESSAGE"].Direction = ParameterDirection.Output;

                try
                {
                    con.Open();
                    cmd.ExecuteNonQuery();

                    //string OUTPUTMESSAGE = (string)cmd.Parameters["@OUTPUTMESSAGE"].Value;
                    return "SUCCESS";

                }
                catch (SqlException ex)
                {

                    LogError(ex);
                    return "ERROR";
                }
                finally
                {
                    con.Close();
                }
            }
        }

        public DataTable GetSetting(string labid)
        {
            DataTable dt = new DataTable();
            using (SqlConnection con = new SqlConnection(ConnectionString))
            using (SqlCommand cmd = new SqlCommand("[LMS_Triopod_User].[PROCSETTING]", con))
            {

                using (SqlDataAdapter sda = new SqlDataAdapter())
                {
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.Add("@LabID", SqlDbType.Int).Value = int.Parse(labid);
                    cmd.Parameters.Add("@option", SqlDbType.Int).Value = 2;
                    try
                    {
                        con.Open();
                        sda.SelectCommand = cmd;
                        sda.Fill(dt);

                    }
                    catch (SqlException ex)
                    {
                        LogError(ex);
                        return null;
                    }
                    finally
                    {
                        con.Close();
                    }
                    return dt;
                }
            }
        }

        public void LogError(Exception ex)
        {
            string message = string.Format("Time: {0}", DateTime.Now.ToString("dd/MM/yyyy hh:mm:ss tt"));
            String logFileName = "Err" + System.DateTime.Now.ToString("_dd-MM-yyyy") + ".txt";
            message += Environment.NewLine;
            message += "---------------------------------------------------------------------------------------------------------------";
            message += Environment.NewLine;
            message += string.Format("Message:{0}", ex.Message);
            message += Environment.NewLine;
            message += string.Format("StackTrace:{0}", ex.StackTrace);
            message += Environment.NewLine;
            message += string.Format("Source:{0}", ex.Source);
            message += Environment.NewLine;
            message += string.Format("TargetSite:{0}", ex.TargetSite);
            message += Environment.NewLine;
            message += "-----------------------------------------------------------------------------------------------------------------";
            message += Environment.NewLine;
            string path = System.Web.HttpContext.Current.Server.MapPath("~/Admin/ErrorLog/" + logFileName);
            using (StreamWriter writer = new StreamWriter(path, true))
            {
                writer.WriteLine(message);
                writer.Close();
            }
        }

    }
}