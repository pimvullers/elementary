# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

VALA_MIN_API_VERSION=0.22

inherit meson vala

DESCRIPTION="An easy parental controls plug for Switchboard"
HOMEPAGE="https://github.com/elementary/switchboard-plug-parental-controls"
SRC_URI="https://github.com/elementary/switchboard-plug-parental-controls/archive/${PV}.tar.gz -> switchboard-plug-parental-controls-${PV}.tar.gz"

S="${WORKDIR}/switchboard-plug-parental-controls-${PV}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"
IUSE="systemd"

RDEPEND="
	!pantheon-base/switchboard-plug-parental-controls:0
	dev-libs/glib:2
	dev-libs/granite:7
	dev-libs/libgee:0.8
	dev-libs/malcontent
	pantheon-base/switchboard:3
	sys-auth/polkit
	systemd? ( sys-apps/systemd )
	sys-apps/accountsservice
	sys-apps/flatpak
	gui-libs/gtk:4
	gui-libs/libadwaita:1
"
DEPEND="${RDEPEND}
	$(vala_depend)
	virtual/pkgconfig
"

src_prepare() {
	eapply_user
	use systemd || sed -i -e '/systemd_dep/d' meson.build data/meson.build
	vala_setup
}

src_install() {
	meson_src_install
	rm -r "${ED}/usr/lib64"
	for d in doc icons locale metainfo polkit-1; do
		rm -r "${ED}/usr/share/${d}"
	done
}
