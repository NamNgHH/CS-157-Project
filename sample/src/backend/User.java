package backend;

public class User {
    private int userID;
    private String name;
    private int age;
    private float weight;
    private float height;
    private String activityLevel;

    public User(int userID, String name, int age, float weight, float height, String activityLevel) {
        this.userID = userID;
        this.name = name;
        this.age = age;
        this.weight = weight;
        this.height = height;
        this.activityLevel = activityLevel;
    }

    // Getters
    public int getUserID() {
        return userID;
    }

    public String getName() {
        return name;
    }

    public int getAge() {
        return age;
    }

    public float getWeight() {
        return weight;
    }

    public float getHeight() {
        return height;
    }

    public String getActivityLevel() {
        return activityLevel;
    }

    // Setters
    public void setUserID(int userID) {
        this.userID = userID;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setAge(int age) {
        this.age = age;
    }

    public void setWeight(float weight) {
        this.weight = weight;
    }

    public void setHeight(float height) {
        this.height = height;
    }

    public void setActivityLevel(String activityLevel) {
        this.activityLevel = activityLevel;
    }
}
