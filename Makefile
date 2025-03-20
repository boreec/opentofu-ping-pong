cluster_ready:
	@if minikube status | grep -q "Running"; then \
		echo "Minikube is already running"; \
	else \
		minikube start --memory=2048 --disk-size=2g; \
	fi

deploy: cluster_ready
	cd infrastructure && \
  sh -c 'eval $$(minikube docker-env) && tofu init && tofu plan && tofu apply --auto-approve'

clean:
	minikube delete
