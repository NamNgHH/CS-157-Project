<form action="addUser" method="post">
    <label>User ID: <input type="number" name="userID" required></label><br>
    <label>Name: <input type="text" name="name" required></label><br>
    <label>Age: <input type="number" name="age" required></label><br>
    <label>Weight: <input type="number" step="0.1" name="weight" required></label><br>
    <label>Height: <input type="number" step="0.1" name="height" required></label><br>
    <label>Activity Level:
        <select name="activityLevel" required>
            <option value="Light">Light</option>
            <option value="Moderate">Moderate</option>
            <option value="Active">Active</option>
        </select>
    </label><br><br>
    <input type="submit" value="Add User">
</form>
