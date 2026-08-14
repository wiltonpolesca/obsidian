## Goal

Read the TxtSql component, extract the SQL Parameters using SqlParameterParser and populate the DtgVariables with the parameters, allowing the user to input the value for each parameter.


# Goal

When the user clicks on BtnExecute button, it should read the DtgVariables control and create a dictionary <string, object>.
- If DataType is a string (3 column) the object must be an string
- If DataType is a int, the object must be an int

# Goal: Show results

- Replace the text component TxtResult by a DataGridView component
- Change the btnExecute to show the result on the grid instead of text component.
- Clean up the grid if the user change the connection info, sql command or any parameter

