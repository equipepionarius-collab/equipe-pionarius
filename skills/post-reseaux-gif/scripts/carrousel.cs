// Moteur de dessin du carrousel animé (GIF). Utilisé par carrousel-gif.ps1.
using System;
using System.Collections.Generic;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.Drawing.Text;

public static class Carrousel {
  public static int W = 800, H = 1000, Total = 1;
  public static Color Fond, Carte, Texte, Sec, Accent, Vert, Rouge, Gris;
  public static string Bandeau = "", Police = "Segoe UI";
  public static Image Logo;
  public static List<Bitmap> Images = new List<Bitmap>();
  public static List<int> Delais = new List<int>();

  public static void Theme(string fond, string carte, string texte, string sec, string accent) {
    Fond = ColorTranslator.FromHtml(fond); Carte = ColorTranslator.FromHtml(carte); Texte = ColorTranslator.FromHtml(texte);
    Sec = ColorTranslator.FromHtml(sec); Accent = ColorTranslator.FromHtml(accent);
    Vert = Color.FromArgb(34, 197, 94); Rouge = Color.FromArgb(239, 68, 68); Gris = Color.FromArgb(71, 85, 105);
  }

  static Font F(float s, bool b) { return new Font(Police, s, b ? FontStyle.Bold : FontStyle.Regular, GraphicsUnit.Pixel); }
  static float Hauteur(Graphics g, string s, float size, bool bold, float w) {
    if (string.IsNullOrEmpty(s)) return 0;
    using (var f = F(size, bold)) return g.MeasureString(s, f, (int)w).Height;
  }
  // Écrit un texte et renvoie la hauteur utilisée ; réduit la taille si le texte déborde de maxH.
  static float T(Graphics g, string s, float size, bool bold, Color c, float x, float y, float w, float maxH, StringAlignment al = StringAlignment.Near) {
    if (string.IsNullOrEmpty(s)) return 0;
    while (size > 14 && Hauteur(g, s, size, bold, w) > maxH) size -= 2;
    using (var f = F(size, bold)) using (var br = new SolidBrush(c)) using (var sf = new StringFormat { Alignment = al }) {
      var h = g.MeasureString(s, f, (int)w).Height;
      g.DrawString(s, f, br, new RectangleF(x, y, w, h + 4), sf);
      return h;
    }
  }
  static void RR(Graphics g, Color c, float x, float y, float w, float h, float r) {
    using (var p = new GraphicsPath()) {
      p.AddArc(x, y, 2 * r, 2 * r, 180, 90); p.AddArc(x + w - 2 * r, y, 2 * r, 2 * r, 270, 90);
      p.AddArc(x + w - 2 * r, y + h - 2 * r, 2 * r, 2 * r, 0, 90); p.AddArc(x, y + h - 2 * r, 2 * r, 2 * r, 90, 90);
      p.CloseFigure(); using (var b = new SolidBrush(c)) g.FillPath(b, p);
    }
  }
  static void Marque(Graphics g, bool ok, float cx, float cy, float r) {
    using (var b = new SolidBrush(ok ? Vert : Rouge)) g.FillEllipse(b, cx - r, cy - r, 2 * r, 2 * r);
    using (var pen = new Pen(Color.White, 5) { StartCap = LineCap.Round, EndCap = LineCap.Round }) {
      if (ok) { g.DrawLine(pen, cx - r * 0.45f, cy, cx - r * 0.1f, cy + r * 0.35f); g.DrawLine(pen, cx - r * 0.1f, cy + r * 0.35f, cx + r * 0.5f, cy - r * 0.35f); }
      else { float k = r * 0.38f; g.DrawLine(pen, cx - k, cy - k, cx + k, cy + k); g.DrawLine(pen, cx - k, cy + k, cx + k, cy - k); }
    }
  }
  static Graphics Debut(int idx, out Bitmap bmp) {
    bmp = new Bitmap(W, H);
    var g = Graphics.FromImage(bmp);
    g.SmoothingMode = SmoothingMode.AntiAlias; g.TextRenderingHint = TextRenderingHint.AntiAliasGridFit; g.InterpolationMode = InterpolationMode.HighQualityBicubic;
    g.Clear(Fond);
    float x = 60;
    if (Logo != null) { g.DrawImage(Logo, 60, 40, 44, 44); x = 118; }
    T(g, Bandeau, 18, true, Accent, x, 52, W - x - 60, 30);
    float pas = 22, x0 = (W - (Total * pas - 12)) / 2f;
    for (int i = 0; i < Total; i++) using (var b = new SolidBrush(i == idx ? Texte : Gris)) g.FillEllipse(b, x0 + i * pas, H - 65, 10, 10);
    return g;
  }
  static void Fin(Bitmap b, Graphics g, int cs) { g.Dispose(); Images.Add(b); Delais.Add(cs); }
  static string Nombre(double v) { return ((long)Math.Round(v)).ToString("N0", new System.Globalization.CultureInfo("fr-FR")); }
  static double Ease(double t) { return 1 - Math.Pow(1 - t, 3); }

  public static void Accroche(int idx, string grand, string titre, string texte, string bas, int cs) {
    Bitmap b; var g = Debut(idx, out b);
    float y = 170;
    y += T(g, grand, 150, true, Texte, 50, y, W - 100, 200) + 10;
    y += T(g, titre, 50, true, Texte, 60, y, W - 120, 240) + 40;
    T(g, texte, 30, false, Sec, 60, y, W - 120, 200);
    T(g, bas, 30, true, Accent, 60, H - 210, W - 120, 90);
    Fin(b, g, cs);
  }

  public static void Chiffre(int idx, string titre, double nombre, string legende, string nombre2, string legende2, string note, bool anime, int cs) {
    int n = anime ? 9 : 1;
    for (int f = 1; f <= n; f++) {
      double t = anime ? Ease(f / 9.0) : 1;
      Bitmap b; var g = Debut(idx, out b);
      float y = 110;
      y += T(g, titre, 52, true, Texte, 60, y, W - 120, 150) + 30;
      y += T(g, Nombre(nombre * t), 150, true, Accent, 50, y, W - 100, 200);
      y += T(g, legende, 30, false, Texte, 60, y, W - 120, 110) + 30;
      if (f == n) {
        if (!string.IsNullOrEmpty(nombre2)) {
          y += T(g, nombre2, 120, true, Texte, 50, y, W - 100, 160);
          y += T(g, legende2, 30, false, Texte, 60, y, W - 120, 110) + 30;
        }
        T(g, note, 24, false, Sec, 60, Math.Max(y, H - 260), W - 120, 150);
      }
      Fin(b, g, f < n ? 7 : cs);
    }
  }

  public static void Liste(int idx, string titre, string sousTitre, string[] items, bool numerote, int cs) {
    Bitmap b; var g = Debut(idx, out b);
    float y = 110;
    y += T(g, titre, 54, true, Texte, 60, y, W - 120, 150) + 10;
    if (!string.IsNullOrEmpty(sousTitre)) y += T(g, sousTitre, 30, true, Accent, 60, y, W - 120, 100) + 20;
    float dispo = H - 110 - y, hCarte = Math.Min(160, dispo / Math.Max(1, items.Length) - 20);
    for (int i = 0; i < items.Length; i++) {
      RR(g, Carte, 60, y, W - 120, hCarte, 20);
      float xt = 90;
      if (numerote) {
        using (var br = new SolidBrush(Accent)) g.FillEllipse(br, 85, y + hCarte / 2 - 28, 56, 56);
        T(g, (i + 1).ToString(), 30, true, Texte, 85, y + hCarte / 2 - 22, 56, 50, StringAlignment.Center);
        xt = 165;
      }
      float hT = Hauteur(g, items[i], 27, false, W - 60 - xt - 25);
      T(g, items[i], 27, false, Texte, xt, y + Math.Max(12, (hCarte - hT) / 2), W - 60 - xt - 25, hCarte - 20);
      y += hCarte + 20;
    }
    Fin(b, g, cs);
  }

  public static void Etapes(int idx, string titre, string sousTitre, string[] items, bool[] ok, int cs) {
    for (int k = 1; k <= items.Length; k++) {
      Bitmap b; var g = Debut(idx, out b);
      float y = 110;
      y += T(g, titre, 50, true, Texte, 60, y, W - 120, 150);
      if (!string.IsNullOrEmpty(sousTitre)) y += T(g, sousTitre, 28, false, Sec, 60, y, W - 120, 80);
      y += 40;
      float hCarte = Math.Min(115, (H - 110 - y) / items.Length - 25);
      for (int i = 0; i < k; i++) {
        RR(g, Carte, 60, y, W - 120, hCarte, 20);
        Marque(g, ok[i], 115, y + hCarte / 2, 26);
        T(g, (i + 1) + ". " + items[i], 28, true, Texte, 165, y + 18, W - 240, hCarte - 24);
        y += hCarte + 25;
      }
      Fin(b, g, k < items.Length ? 100 : cs);
    }
  }

  public static void Barres(int idx, string titre, string sousTitre, string[] etiquettes, double[] valeurs, int accent, int cs) {
    double max = 0; foreach (var v in valeurs) max = Math.Max(max, v);
    if (max <= 0) max = 1;
    if (accent < 0) accent = valeurs.Length - 1;
    for (int f = 1; f <= 9; f++) {
      double t = Ease(f / 9.0);
      Bitmap b; var g = Debut(idx, out b);
      float y = 110;
      y += T(g, titre, 42, true, Texte, 60, y, W - 120, 120);
      T(g, sousTitre, 26, false, Sec, 60, y + 4, W - 120, 90);
      float baseY = H - 180, top = 330, band = (W - 120f) / valeurs.Length, bw = band * 0.62f;
      using (var pen = new Pen(Gris, 2)) g.DrawLine(pen, 60, baseY, W - 60, baseY);
      for (int i = 0; i < valeurs.Length; i++) {
        float h = (float)(valeurs[i] / max * (baseY - top) * t);
        float hv = valeurs[i] > 0 ? Math.Max(h, 2) : 0;
        float x = 60 + i * band + (band - bw) / 2;
        using (var br = new SolidBrush(i == accent ? Accent : Gris)) g.FillRectangle(br, x, baseY - hv, bw, hv);
        if (f == 9) T(g, Nombre(valeurs[i]), 20, true, Texte, x - 30, baseY - hv - 32, bw + 60, 30, StringAlignment.Center);
        T(g, etiquettes[i], 20, false, Sec, x - 30, baseY + 10, bw + 60, 30, StringAlignment.Center);
      }
      Fin(b, g, f < 9 ? 7 : cs);
    }
  }

  public static void Comparaison(int idx, string titre, string colA, string colB, string[] lignes, string[] a, string[] bb, string encart, int cs) {
    Bitmap b; var g = Debut(idx, out b);
    float y = 110;
    y += T(g, titre, 54, true, Texte, 60, y, W - 120, 150) + 20;
    T(g, colA, 26, true, Texte, 260, y, 230, 40, StringAlignment.Center);
    T(g, colB, 26, true, Texte, 500, y, 240, 40, StringAlignment.Center);
    y += 55;
    float hL = Math.Min(125, (H - 110 - y - (string.IsNullOrEmpty(encart) ? 0 : 150)) / Math.Max(1, lignes.Length) - 18);
    for (int i = 0; i < lignes.Length; i++) {
      RR(g, Carte, 60, y, W - 120, hL, 18);
      T(g, lignes[i], 24, true, Sec, 80, y + 18, 170, hL - 20);
      T(g, a[i], 24, false, Texte, 265, y + 18, 220, hL - 20, StringAlignment.Center);
      T(g, bb[i], 24, false, Texte, 505, y + 18, 220, hL - 20, StringAlignment.Center);
      y += hL + 18;
    }
    if (!string.IsNullOrEmpty(encart)) { RR(g, Accent, 60, y + 10, W - 120, 130, 18); T(g, encart, 28, true, Color.White, 90, y + 32, W - 180, 100); }
    Fin(b, g, cs);
  }

  public static void Analyse(int idx, string surtitre, string titre, string texte, string fort, string[] pastilles, int cs) {
    Bitmap b; var g = Debut(idx, out b);
    float y = 120;
    y += T(g, surtitre, 30, true, Accent, 60, y, W - 120, 50) + 10;
    y += T(g, titre, 62, true, Texte, 60, y, W - 120, 200) + 20;
    y += T(g, texte, 32, false, Texte, 60, y, W - 120, 130) + 30;
    T(g, fort, 32, true, Texte, 60, y, W - 120, 160);
    if (pastilles != null && pastilles.Length > 0) {
      float x = 60, larg = (W - 120 - 15 * (pastilles.Length - 1)) / (float)pastilles.Length;
      foreach (var p in pastilles) { RR(g, Carte, x, H - 280, larg, 60, 30); T(g, p, 21, true, Texte, x + 8, H - 265, larg - 16, 40, StringAlignment.Center); x += larg + 15; }
    }
    Fin(b, g, cs);
  }

  public static void Cta(int idx, string titre, string etape1, string etape2, string motCle, string texte, int cs) {
    Bitmap b; var g = Debut(idx, out b);
    T(g, titre, 54, true, Texte, 60, 110, W - 120, 150);
    RR(g, Carte, 60, 280, W - 120, 110, 20);
    T(g, etape1, 28, true, Texte, 90, 312, W - 180, 70);
    RR(g, Carte, 60, 410, W - 120, 230, 20);
    T(g, etape2, 28, true, Texte, 90, 435, W - 180, 60);
    RR(g, Accent, 140, 510, W - 280, 100, 20);
    T(g, motCle, 54, true, Color.White, 140, 522, W - 280, 80, StringAlignment.Center);
    T(g, texte, 30, false, Texte, 60, 680, W - 120, 150);
    Fin(b, g, cs);
  }

  static byte[] Sub(byte[] d, int s, int n) { var r = new byte[n]; Array.Copy(d, s, r, 0, n); return r; }
  // Ajoute la boucle infinie et la durée de chaque image au GIF produit par WPF.
  public static byte[] Animer(byte[] d, int[] delais) {
    var o = new List<byte>(); int p = 13; int packed = d[10];
    o.AddRange(Sub(d, 0, 13));
    if ((packed & 0x80) != 0) { int n = 3 * (1 << ((packed & 7) + 1)); o.AddRange(Sub(d, 13, n)); p += n; }
    o.AddRange(new byte[] { 0x21, 0xFF, 0x0B }); o.AddRange(System.Text.Encoding.ASCII.GetBytes("NETSCAPE2.0")); o.AddRange(new byte[] { 3, 1, 0, 0, 0 });
    int fi = 0;
    while (p < d.Length) {
      byte b = d[p];
      if (b == 0x21) { int s = p; byte lab = d[p + 1]; p += 2; while (d[p] != 0) p += d[p] + 1; p++; if (lab != 0xF9 && lab != 0xFF) o.AddRange(Sub(d, s, p - s)); }
      else if (b == 0x2C) {
        int dl = fi < delais.Length ? delais[fi] : 100; fi++;
        o.AddRange(new byte[] { 0x21, 0xF9, 4, 4, (byte)(dl & 255), (byte)(dl >> 8), 0, 0 });
        int s = p; int pk = d[p + 9]; p += 10; if ((pk & 0x80) != 0) p += 3 * (1 << ((pk & 7) + 1)); p++;
        while (d[p] != 0) p += d[p] + 1; p++;
        o.AddRange(Sub(d, s, p - s));
      } else if (b == 0x3B) { o.Add(0x3B); break; } else p++;
    }
    return o.ToArray();
  }
}
