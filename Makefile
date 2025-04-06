GRAFANA_URL=$(shell minikube ip):30080

clean:
	minikube delete

cluster_ready:
	@if minikube status | grep -q "Running"; then \
		echo "Minikube is already running"; \
	else \
		minikube start --cpus='max' --memory=2048 --disk-size=2g --addons=ingress; \
	fi

deploy: cluster_ready
	cd infrastructure && \
	sh -c 'eval $$(minikube docker-env) && \
		tofu init -compact-warnings -lock=false -input=false -no-color && \
		tofu plan -compact-warnings -concise -lock=false -input=false -no-color && \
		tofu apply --auto-approve'

open-grafana:
	@echo "Opening Grafana at http://$(GRAFANA_URL)"
	@if [ "$$(uname)" = "Darwin" ]; then \
		open http://$(GRAFANA_URL); \
	elif [ "$$(uname)" = "Linux" ]; then \
		xdg-open http://$(GRAFANA_URL); \
	else \
		echo "Unsupported OS"; \
	fi
