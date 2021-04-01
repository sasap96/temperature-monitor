import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
/*
"1000000" when "0000", 
"1111001" when "0001", 
"0100100" when "0010", 
"0110000" when "0011", 
"0011001" when "0100", 
"0010010" when "0101", 
"0000010" when "0110", 
"1111000" when "0111", 
"0000000" when "1000", 
"0010000" when "1001", 
"1111111" when others;
*/

public class TestBench {

	public static int convBcd(String output) {
		if (output.equals("1000000"))
			return 0;
		if (output.equals("1111001"))
			return 1;
		if (output.equals("0100100"))
			return 2;
		if (output.equals("0110000"))
			return 3;
		if (output.equals("0011001"))
			return 4;
		if (output.equals("0010010"))
			return 5;
		if (output.equals("0000010"))
			return 6;
		if (output.equals("1111000"))
			return 7;
		if (output.equals("0000000"))
			return 8;
		if (output.equals("0010000"))
			return 9;
		return -1;
	}

	static String find2complement(StringBuffer str) {
		int n = str.length();

		int i;
		for (i = n - 1; i >= 0; i--)
			if (str.charAt(i) == '1')
				break;

		if (i == -1)
			return "1" + str;

		for (int k = i - 1; k >= 0; k--) {

			if (str.charAt(k) == '1')
				str.replace(k, k + 1, "0");
			else
				str.replace(k, k + 1, "1");
		}

		return str.toString();
	}

	public static double convertToFloat(String input, int prec) {

		double int_num;
		boolean flag = input.charAt(0) == '1';
		if (flag) {

			input = find2complement(new StringBuffer(input));

		}

		int_num = Integer.parseInt(input.substring(5, 12), 2);

		double dec_num = 0;
		double pow = 2.0;

		for (int i = 12; i <= 12 + prec; i++) {
			dec_num = dec_num + (input.charAt(i) - '0') / pow;
			pow = pow * 2;
		}

		return flag ? -1 * (int_num + dec_num) : int_num + dec_num;
	}

	public static void main(String[] args) throws FileNotFoundException, IOException {

		try (BufferedReader br = new BufferedReader(new FileReader("data.csv"))) {

			String line;
			line = br.readLine();
			while ((line = br.readLine()) != null) {

				String[] values = line.split(",");

				int prec = Integer.parseInt(values[1], 2);
				String sign = values[8].equals("1") ? "-" : "+";
				
				double temp = Float
						.parseFloat(sign + "" + convBcd(values[7]) + "" + convBcd(values[6]) + "." + convBcd(values[5])
								+ "" + convBcd(values[4]) + "" + convBcd(values[3]) + "" + convBcd(values[2]));
				
				double javaTemp = convertToFloat(values[0], prec);
				
				if (temp < 100 && javaTemp < 100 && temp < -100 && javaTemp < -100)
					if (temp != javaTemp)
						System.out.println(temp + "  " + javaTemp);

				// vrijednosti iz tabele u datasheetu
				/*
				 * if(values[0].equals("1111111001101111")){ //-25.0625 datasheet
				 * System.out.print(prec+"-"); System.out.println(c); }
				 */

				/*
				 * if(values[0].equals("0000000110010001")) { //25.0625 datasheet
				 * System.out.print(prec+"-"); System.out.println(c); }
				 */

				/*
				 * if(values[0].equals("1111110010010000")){ //-55 datasheet
				 * System.out.print(prec+"-"); System.out.println(c); }
				 */

				/*
				 * if(values[0].equals("1111110010010000")){ //-55 datasheet
				 * System.out.print(prec+"-"); System.out.println(c); }
				 */

				/*
				 * if(values[0].equals("1111111101011110")){ //-10.125 datasheet
				 * System.out.print(prec+"-"); System.out.println(c); }
				 */

				/*
				 * if(values[0].equals("0000000010100010")){ //-10.125 datasheet
				 * System.out.print(prec+"-"); System.out.println(c); }
				 */

			}
		}
	}
}
