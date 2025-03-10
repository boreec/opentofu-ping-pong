mod server;

#[tokio::main]
async fn main() {
    let s = server::Server::new();
    s.run().await;
}
