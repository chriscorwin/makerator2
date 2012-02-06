[//lasso
	Define_Tag: 'Gzip', -Namespace='Compress_', -Required='data', -Optional='name';
		Local: 'bytes' = Bytes;
		// ID 1 - Fixed value (31)
		#bytes->(Import8Bits: 0x1f);
		// ID 2 - Fixed value (139)
		#bytes->(Import8Bits: 0x8b);
		// CM - Compression Method (8 Deflate)
		#bytes->(Import8Bits: 0x08);
		// FLG - Flags (8 = FNAME, 0 = NONE)
		if: (local_defined: 'name');
			#bytes->(Import8Bits: 0x08);
		else;
			#bytes->(Import8Bits: 0x00);
		/if;
		// MTIME - Compression Time (0 Unavailable)
		Local: 'time' = (integer: date);
		#bytes->(Import8Bits: #time % 256);
		#time = (#time - (#time % 256)) / 256;
		#bytes->(Import8Bits: #time % 256);
		#time = (#time - (#time % 256)) / 256;
		#bytes->(Import8Bits: #time % 256);
		#time = (#time - (#time % 256)) / 256;
		#bytes->(Import8Bits: #time % 256);
		// XFL - Extra Flags (0 None)
		#bytes->(Import8Bits: 0x00);
		// OS - Operating System (255 Unknown)
		#bytes->(Import8Bits: 0xFF);
		// FNAME
		if: (local_defined: 'name');
			#bytes->(importstring: (string_replaceregexp: #name, -find='.*/', -replace=''), 'iso-8859-1');
			#bytes->(import8bits: 0x00);
		/if;
		// DATA
		local: 'temp'= (Compress: #data);
		#bytes += #temp->(getrange: 7, #temp->size - 10);
		// CRC32
		local: 'crc' = (Encode_CRC32: #data);
		#bytes->(Import8Bits: #crc % 256);
		#crc = (#crc - (#crc % 256)) / 256;
		#bytes->(Import8Bits: #crc % 256);
		#crc = (#crc - (#crc % 256)) / 256;
		#bytes->(Import8Bits: #crc % 256);
		#crc = (#crc - (#crc % 256)) / 256;
		#bytes->(Import8Bits: #crc % 256);
		// ISIZE 
		Local: 'size' = #data->size;
		#bytes->(Import8Bits: #size % 256);
		#size = (#size - (#size % 256)) / 256;
		#bytes->(Import8Bits: #size % 256);
		#size = (#size - (#size % 256)) / 256;
		#bytes->(Import8Bits: #size % 256);
		#size = (#size - (#size % 256)) / 256;
		#bytes->(Import8Bits: #size % 256);
		Return: @#bytes;
	/Define_Tag;



	/* SVN $Id: compress_gzip.inc 250 2006-06-22 23:35:53Z Jason Huck $ */
]