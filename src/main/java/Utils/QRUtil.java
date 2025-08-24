/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Utils;

import com.google.zxing.*;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;

import java.io.ByteArrayOutputStream;
import java.nio.file.FileSystems;
import java.nio.file.Path;
import java.awt.image.BufferedImage;
import java.io.IOException;
import javax.imageio.ImageIO;

public class QRUtil {

    // Generates QR as ByteArrayOutputStream (for Base64 encoding)
    public static ByteArrayOutputStream generateQRCode(String text, int width, int height) throws WriterException, IOException {
        ByteArrayOutputStream baos = new ByteArrayOutputStream();

        BitMatrix matrix = new MultiFormatWriter().encode(text, BarcodeFormat.QR_CODE, width, height);
        BufferedImage image = MatrixToImageWriter.toBufferedImage(matrix);

        ImageIO.write(image, "png", baos);
        return baos;
    }
}
