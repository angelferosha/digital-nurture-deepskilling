public class BuilderTest {
    public static void main(String[] args) {
        Computer gamingPC = new Computer.Builder()
                .setCpu("Intel i9")
                .setRam("32GB")
                .setStorage("1TB SSD")
                .setGraphicsCard(true)
                .build();

        Computer officePC = new Computer.Builder()
                .setCpu("Intel i5")
                .setRam("8GB")
                .setStorage("512GB SSD")
                .setGraphicsCard(false)
                .build();

        System.out.println(gamingPC);
        System.out.println(officePC);
    }
}
