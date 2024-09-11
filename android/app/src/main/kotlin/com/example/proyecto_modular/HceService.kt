package com.example.proyecto_modular

import android.nfc.cardemulation.HostApduService
import android.os.Bundle

class HceService : HostApduService() {

    override fun processCommandApdu(commandApdu: ByteArray, extras: Bundle?): ByteArray {
        // Aquí puedes procesar el comando APDU y devolver la respuesta adecuada
        // En este ejemplo, se responde con un comando genérico, debes ajustar esto según tu necesidad
        return byteArrayOf(0x00.toByte(), 0x00.toByte(), 0x00.toByte(), 0x00.toByte())
    }

    override fun onDeactivated(reason: Int) {
        // Aquí puedes manejar la desactivación del servicio HCE
    }
}
