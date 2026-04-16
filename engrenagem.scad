// Parâmetros principais
num_dentes = 10;
raio_base = 6;
comprimento_dente = 3;
largura_dente = 3.0;
espessura = 3;
raio_furo = 2;

$fn = 80; // suavidade geral

module dente_arredondado() {
    hull() {
        // Base do dente (mais largo)
        translate([raio_base, 0, 0])
            cylinder(h = espessura, r = largura_dente/2);

        // Ponta do dente (mesma largura → ponta arredondada)
        translate([raio_base + comprimento_dente, 0, 0])
            cylinder(h = espessura, r = largura_dente/2);
    }
}

module engrenagem_arredondada() {
    difference() {
        union() {
            // Corpo base
            cylinder(h = espessura, r = raio_base, $fn = 100);

            // Dentes
            for (i = [0 : num_dentes - 1]) {
                angle = i * 360 / num_dentes;

                rotate([0, 0, angle])
                    dente_arredondado();
            }
        }

        // Furo central
        translate([0, 0, -1])
            cylinder(h = espessura + 2, r = raio_furo, $fn = 100);
    }
}

// Render
engrenagem_arredondada();