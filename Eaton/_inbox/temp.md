## Compilers, build tools, and runtimes

- MSVC v143 - VS 2022 C++ x64/x86 build tools (v14.44-17-14)

![[Pasted image 20260423090542.png]]
### SDKs, libraries, and frameworks
- C++ ATL for x64/x86 (Latest MSVC)
![[Pasted image 20260423095657.png]]

- C++ v14.[xx] (1[x].[xx]) ATL for v143 build tools (x86 & x64)
- C++ v14.[xx] (1[x].[xx]) MFC for v143 build tools (x86 & x64)
![[Pasted image 20260423095959.png]]












- C++ ATL for v141 build tools (x86 &  x64)

- C++ ATL for v141 build tools with Spectre Mitigations (x86 &  x64)
- C++ ATL for v141 (Latest MSVC)

- C++ 14.29 (16.11) ATL for v142 build tools (x86 &  x64)
- C++ 14.29 (16.11) ATL for v142 build tools with Spectre Mitigations (x86 &  x64)

- C++ 14.29 (16.11) ATL for v143 build tools (x86 &  x64)
- C++ 14.29 (16.11) ATL for v143 build tools with Spectre Mitigations (x86 &  x64)
- C++ 14.29 (16.11) MFC for v143 build tools (x86 &  x64)

![[Pasted image 20260423084951.png]]

![[Pasted image 20260423090139.png]]

![[Pasted image 20260423090907.png]]
grafana:

    container_name: grafana

    image: grafana/otel-lgtm

    volumes:

      - ./settings/grafana/grafana-datasources.yml:/etc/grafana/provisioning/datasources/datasources.yml

    environment:

      GF_AUTH_ANONYMOUS_ENABLED: "true"

      GF_AUTH_ANONYMOUS_ORG_ROLE: "Admin"

    ports:

      - 3000:3000

      - 4318:4318

    networks:

      - dev_local