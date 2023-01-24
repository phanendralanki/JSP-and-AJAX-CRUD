<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP and AJAX CRUD</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">

        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>

        <link rel="stylesheet" href="//cdn.datatables.net/1.13.1/css/jquery.dataTables.min.css">

    </head>
    <body>

        <nav class="navbar navbar-dark bg-primary">
            <h2 style="color:white;">Student Management System</h2>
        </nav>
        <br><br>
        <div class="row">

            <div class="col-sm-4">
                <div class="container">
                    <form id="formStudent" name="formStudent">

                        <div class="form-group">
                            <label>Student Name:</label>
                            <input type="text" name="stname" id="stname" class="form-control" placeholder="StudentName" size="30px" required/>

                        </div>

                        <div class="form-group">
                            <label>Course</label>
                            <input type="text" class="form-control" name="course" id="course" placeholder="course" size="30px" required/>

                        </div>

                        <div class="form-group">
                            <label>Fee</label>
                            <input type="text" class="form-control" name="fee" id="fee" placeholder="Fee" size="30px" required/>

                        </div>

                        <div class="form-group" align="right">
                            <button type="button" class="btn btn-info" id="save" onclick="addStudent()">Add</button>
                            <button type="reset" class="btn btn-warning" id="save" onclick="reSet()">Reset</button>
                        </div>


                    </form>
                </div> 
            </div>

            <div class="col-sm-8">

                <div class="panel-body">
                    <table id="tbl-student" class="table table-bordered" cellpadding="0" cellspacing="0" width="100%">

                        <thead>
                            <tr> 
                                <th></th>
                                <th></th><!-- comment -->
                                <th></th> 
                                <th></th> 
                                <th></th>
                            </tr>    
                        </thead>

                    </table>
                </div>

            </div>

        </div>

        <script src="component/jquery/jquery.js" type="text/javascript"></script>

        <script src="component/jquery/jquery.min.js" type="text/javascript"></script>

        <script src="component/jquery.validate.min.js" type="text/javascript"></script>

        <!--Datatables-->
        <script src="//cdn.datatables.net/1.13.1/js/jquery.dataTables.min.js" type="text/javascript"></script>

        <script>
                                getall();
                                var isNew = true;
                                var studentid = null;

                                function addStudent() {
                                    //alert("working...");

                                    //form validation 
                                    if ($("#formStudent").valid())
                                    {
                                        var url = "";
                                        var data = "";
                                        var method = "";

                                        if (isNew == true) {
                                            url = 'add.jsp';
                                            data = $("#formStudent").serialize();
                                            method = 'POST'

                                        } 
                                        else
                                        {

                                            url = 'update.jsp';
                                            data = $("#formStudent").serialize() + "&studentid=" + studentid;
                                            method = 'POST'

                                        }

                                        $.ajax({
                                            type: method,
                                            url: url,
                                            dataType: 'JSON',
                                            data: data,

                                            success: function (data)
                                            {
                                                getall();
                                                
                                                $('#stname').val("");
                                                $('#course').val("");
                                                $('#fee').val("");
                                                
                                                if (isNew == true)
                                                {
                                                    alert("record added");
                                                }
                                                else
                                                {
                                                    alert("Record updated");
                                                }
                                            }
                                        });


                                    }
                                }

                                function getall()
                                {
                                    //alert("welcome");

                                    $("#tbl-student").dataTable().fnDestroy();
                                    $.ajax({

                                        url: "all_student.jsp",
                                        type: "GET",
                                        dataType: "JSON",

                                        success:function (data)
                                        {
                                            $("#tbl-student").dataTable({
                                                "aaData": data,
                                                "scrollX": true,
                                                "aoColumns":
                                                        [
                                                            {"sTitle": "Student Name", "mData": "name"},
                                                            {"sTitle": "Course", "mData": "course"},
                                                            {"sTitle": "fee", "mData": "fee"},

                                                            {
                                                                "sTitle":
                                                                        "Edit",
                                                                "mData": "id",
                                                                "render": function (mData, type, row, meta)
                                                                {
                                                                    return '<button class="btn btn-success" onclick="get_details('+ mData + ')">Edit</button>';
                                                                }
                                                            },

                                                            {
                                                                "sTitle":
                                                                        "Delete",
                                                                "mData": "id",
                                                                "render": function (mData, type, row, meta)
                                                                {
                                                                    return '<button class="btn btn-danger" onclick="get_delete('+ mData + ')">Delete</button>';
                                                                }
                                                            },
                                                        ]
                                            });
                                        }


                                    });
                                }


                                //Editing
                                function get_details(id)
                                {
                                    $.ajax({
                                        type: "POST",
                                        url: "edit_return.jsp",
                                        data: {"id": id},

                                        success: function (data) {
                                            isNew = false;
                                            var obj = JSON.parse(data);
                                            studentid = obj[0].id;
                                            $('#stname').val(obj[0].stname);
                                            $('#course').val(obj[0].scourse);
                                            $('#fee').val(obj[0].sfee);


                                        }
                                    });


                                }


                                function get_delete(id)
                                {
                                    $.ajax({
                                        type: 'POST',
                                        url: 'delete.jsp',
                                        dataType: 'JSON',
                                        data: {"id": id},

                                        success: function (data)
                                        {
                                            alert("deleted");
                                            getall();
                                        }


                                    });
                                }

        </script>
    </body>

</html>
