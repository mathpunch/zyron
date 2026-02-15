cat > /etc/caddy/Caddyfile << 'EOF'
{
    on_demand_tls {
        ask http://localhost:9327
    }
}

https:// {
    tls {
        on_demand
    }
    encode gzip
    handle /bare/* {
        reverse_proxy localhost:5000
    }
    handle /wisp/* {
        reverse_proxy localhost:5000
    }
    reverse_proxy localhost:8001
}

:9327 {
    handle {
        respond "hi, reporting for https sir!" 200
    }
}

zyrongardeningalore.speedinsure.hk {
    handle /wisp/* {
        reverse_proxy localhost:8001
    }
    reverse_proxy localhost:8001
}

kasm.speedinsure.hk {
    reverse_proxy https://localhost:6767 {
        transport http {
            tls_insecure_skip_verify
        }
    }
}
EOF
