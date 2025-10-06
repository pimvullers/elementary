# Copyright 1999-2021 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

VALA_MIN_API_VERSION=0.34

inherit meson vala

DESCRIPTION="Switchboard User Accounts Plug."
HOMEPAGE="https://github.com/elementary/settings-useraccounts"
SRC_URI="https://github.com/elementary/settings-useraccounts/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="3"
KEYWORDS="amd64"

RDEPEND="
	dev-libs/glib:2
	dev-libs/granite:7
	dev-libs/libgee:0.8
	dev-libs/libpwquality
	gnome-base/gnome-desktop:4
	pantheon-base/switchboard:3
	sys-apps/accountsservice
	gui-libs/gtk:4
	gui-libs/libadwaita:1
"
DEPEND="${RDEPEND}
	$(vala_depend)
	virtual/pkgconfig
"
S="${WORKDIR}/settings-useraccounts-${PV}"

src_prepare() {
	eapply_user
	vala_setup
}
