use axum::{Router, routing::get};

// Represents a running server.
pub struct Server {
    http_server: Router,
}

impl Server {
    pub fn new() -> Self {
        return Self {
            http_server: Router::new()
                .route("/healthz", get(healthz))
                .route("/pong", get(pong)),
        };
    }

    pub async fn run(&self) {
        let listener =
            tokio::net::TcpListener::bind("0.0.0.0:3000").await.unwrap();
        axum::serve(listener, self.http_server.clone())
            .await
            .unwrap();
    }
}

async fn healthz() {}

async fn pong() {}
