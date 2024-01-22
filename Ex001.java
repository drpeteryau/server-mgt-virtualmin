public class Ex001 {
    public static void main(String[] args) {
        if (args.length != 2) {
            System.out.println("Please provide two arguments, a and b.");
            return;
        }

        try {
            int a = Integer.parseInt(args[0]);
            int b = Integer.parseInt(args[1]);

            int sum = a + b;
            System.out.println(sum);
        } catch (NumberFormatException e) {
            System.out.println("Invalid input. Please provide valid integers for a and b.");
        }
    }
}
