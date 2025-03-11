use axum::{Router, routing::get};

// Represents a running Server.
pub struct Server {
    http_server: Router,
}

impl Server {
    // Creates a new Server instance.
    pub fn new() -> Self {
        return Self {
            http_server: Router::new()
                .route("/healthz", get(healthz))
                .route("/pong", get(pong)),
        };
    }

    // Runs the Server instance.
    pub async fn run(&self) {
        let listener =
            tokio::net::TcpListener::bind("0.0.0.0:8082").await.unwrap();

        axum::serve(listener, self.http_server.clone())
            .await
            .unwrap();
    }
}

// Handler for the /healthz route.
async fn healthz() -> String {
    "OK\n".to_string()
}

// Handler for the /pong route.
async fn pong() -> String {
    "pong\n".to_string()
}
